using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dataLoadWithAjax : System.Web.UI.Page
	{
	private static HttpCookie cookie = null;
	private static string connect = Constants.conString;
	private string query = "SELECT countryID, name FROM Countries";

	protected void Page_Load(object sender, EventArgs e)
		{

		if(!Page.IsPostBack)
			{
			BindData();
			cookie = Request.Cookies["shopingCartCookies"] ?? new HttpCookie("shopingCartCookies");
			}
		}

	private void BindData()
		{
		using(SqlConnection conn = new SqlConnection(connect))
			{
			using(SqlCommand cmd = new SqlCommand(query, conn))
				{
				conn.Open();
				ddlCountries.DataSource = cmd.ExecuteReader();
				ddlCountries.DataValueField = "countryID";
				ddlCountries.DataTextField = "name";
				ddlCountries.DataBind();
				ddlCountries.Items.Insert(0, "Выберите страну");
				}
			}
		}

	//Метод для добавления товаров в карточку
	[WebMethod]
	public static string AddProductToCart(string productId)
		{

		string description = "";
		string idCart = "";
		string sqlInsertShoppingCards = string.Format("Insert Into ShoppingCards" +
													  "(Description) Values('{0}')", description);
		try
			{
			using(SqlConnection conn = new SqlConnection(connect))
				{

				using(SqlCommand command = conn.CreateCommand())
					{
					conn.Open();
					//Делаем проверку, есть ли карточка
					if(String.IsNullOrEmpty(cookie["idCart"]))
						{
						command.CommandText = sqlInsertShoppingCards;
						command.ExecuteNonQuery();
						command.CommandText = "SELECT @@IDENTITY";
						idCart = command.ExecuteScalar().ToString();
						cookie["idCart"] = idCart;
						command.CommandText = string.Format("Insert Into CardsGoods (goodsID,cardID) Values('{0}','{1}')",
							Int32.Parse(productId), Int32.Parse(idCart));
						command.ExecuteNonQuery();
						}
					else
						{
						idCart = cookie["idCart"];
						command.CommandText = string.Format("Insert Into CardsGoods (goodsID,cardID) Values('{0}','{1}')",
							Int32.Parse(productId), Int32.Parse(idCart));
						command.ExecuteNonQuery();
						}
					conn.Close();
					}
				}
			HttpContext.Current.Response.Cookies.Add(cookie);
			return idCart;
			}
		catch(Exception ex)
			{
			return "failure";
			}

		}

	//Метод для получения списка товаров в карточке
	[WebMethod]
	public static string GetSelectedProduct()
		{
		HttpCookie cookies = HttpContext.Current.Request.Cookies["shopingCartCookies"];
		string cardId = "";
		if(cookies != null)
			{
			cardId = cookies["idCart"];
			}
		string response = "No selected goods";
		string connect = Constants.conString;
		string query =
			"SELECT cg.goodsID as goodsID, g.name as name FROM CardsGoods cg LEFT JOIN Goods g ON cg.goodsID=g.goodsID WHERE cg.cardID=@CardId";

		if(!String.IsNullOrEmpty(cardId))
			{
			StringBuilder sb = new StringBuilder();
			using(SqlConnection conn = new SqlConnection(connect))
				{
				using(SqlCommand cmd = new SqlCommand(query, conn))
					{
					cmd.Parameters.AddWithValue("CardId", cardId);
					conn.Open();
					SqlDataReader rdr = cmd.ExecuteReader();
					if(rdr.HasRows)
						{
						while(rdr.Read())
							{
							sb.Append("<tr>");
							sb.Append("<td value=\"" + rdr["goodsID"] + "\">" + rdr["name"] + "</td>");
							sb.Append("<td><a class=\"btn btn-primary\" id=\"linkDelOrder\" value=\"" + rdr["goodsID"] + "\">Удалить</a></td>");
							sb.Append("</tr>");
							response = sb.ToString();
							}
						}
					}
				conn.Close();
				}
			}

		return response;
		}
	//Метод для удаления выбранного товара 
	[WebMethod]
	public static string DeleteProductFromCart(string productId)
		{
		HttpCookie cookies = HttpContext.Current.Request.Cookies["shopingCartCookies"];
		string cardId = "";
		if(cookies != null)
			{
			cardId = cookies["idCart"];
			}

		string query = "DELETE TOP(1) FROM CardsGoods WHERE cardID=@CardId AND goodsID=@GoodsId";
		try
			{
			using(SqlConnection conn = new SqlConnection(connect))
				{

				using(SqlCommand command = conn.CreateCommand())
					{
					conn.Open();
					//Делаем проверку, есть ли карточка
					if(!String.IsNullOrEmpty(cardId))
						{
						command.Parameters.AddWithValue("CardId", cardId);
						command.Parameters.AddWithValue("GoodsId", productId);
						command.CommandText = query;
						command.ExecuteNonQuery();
						}

					conn.Close();
					}
				}
			return "success";
			}
		catch(Exception ex)
			{
			return "failure";
			}
		}

	}

//Создаем классы сущностей
public class Goods
	{
	public int GoodsId { get; set; }
	public string Name { get; set; }
	public int CountryId { get; set; }
	}

public class ShoppingCards
	{
	public int CardId { get; set; }
	public string Description { get; set; }
	}

public class CardsGoods
	{
	public int CardsGoodsID { get; set; }
	public int GoodsId { get; set; }
	public int CardId { get; set; }
	}