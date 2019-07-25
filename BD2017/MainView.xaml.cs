using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace BD2017
{
    /// <summary>
    /// Interaction logic for MainView.xaml
    /// </summary>
    public partial class MainView : Window
    {
        String username;
        String mail;
        int id;
        public MainView(String user, String email, int id)
        {
            InitializeComponent();
            this.username = user;
            this.mail = email;
            this.id = id;
            this.Title = "Bem vindo " + user;

            SqlConnection s = new SqlConnection("Data Source=LILITH;Initial Catalog=gamemasters;Integrated Security=True");
            s.Open();
            using (var command = s.CreateCommand())
            {
                command.CommandText = "select * FROM dbo.udf_show_games(@ID)";
                command.CommandType = CommandType.Text;
                command.Parameters.Add(new SqlParameter("@ID", this.id));
                //var result = command.ExecuteScalar();

                var dataAdapter = new SqlDataAdapter(command);
                DataTable dtRecord = new DataTable();
                dataAdapter.Fill(dtRecord);
                this.dataGrid.ItemsSource = dtRecord.DefaultView;
            }
            s.Close();

        }
    }
}
