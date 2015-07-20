using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class dataLoadWithAjax : System.Web.UI.Page
{
	static HttpCookie cookie=new HttpCookie("shopingCartCookies");
	
	private static string connect = Constants.conString;
	string query = "SELECT countryID, name FROM Countries";
	protected void Page_Load(object sender, EventArgs e)
		{

		if(!Page.IsPostBack)
			{
			BindData();
			Response.Cookies.Add(cookie);
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
		using (SqlConnection conn = new SqlConnection(connect))
		{
			
			using (SqlCommand command = conn.CreateCommand())
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
					command.CommandText = string.Format("Insert Into CardsGoods (goodsID,cardID) Values('{0}','{1}')",  Int32.Parse(productId), Int32.Parse(idCart));;
					command.ExecuteNonQuery();
				}
				else
				{
					idCart = cookie["idCart"];
					command.CommandText =string.Format("Insert Into CardsGoods (goodsID,cardID) Values('{0}','{1}')",  Int32.Parse(productId), Int32.Parse(idCart));;
					command.ExecuteNonQuery();
				}
				conn.Close();
			}
		}
			return "Success";
		}
		catch (Exception ex)
		{
		return "failure";
		}
		}
	//Метод для получения списка товаров в карточке
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