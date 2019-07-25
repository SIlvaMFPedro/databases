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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace BD2017
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, RoutedEventArgs e)
        {
            Register subWindow = new Register();
            subWindow.Show();
            this.Close();
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            SqlConnection s = new SqlConnection("Data Source=LILITH;Initial Catalog=gamemasters;Integrated Security=True");
            s.Open();
            String username = usern.Text;
            String pass = passwordBox.Password;

            using (var command = s.CreateCommand())
            {
                command.CommandText = "select dbo.Username_Exists(@username, @pass)";
                command.CommandType = CommandType.Text;
                command.Parameters.Add(new SqlParameter("@username", username));
                command.Parameters.Add(new SqlParameter("@pass", pass));
                var result = command.ExecuteScalar();
                if ((int)result == 0)
                {
                    MessageBox.Show("Username ou password errados!", "Invalid Login", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
            }
            String nome = "";
            String mail = "";
            int id = -1;
            using (var command = s.CreateCommand())
            {
                command.CommandText = "select * FROM dbo.get_loginInfo(@username, @pass)";
                command.CommandType = CommandType.Text;
                command.Parameters.Add(new SqlParameter("@username", username));
                command.Parameters.Add(new SqlParameter("@pass", pass));

               var r = command.ExecuteReader();
                while (r.Read())
                {
                    nome = r["Nome"].ToString();
                    mail = r["Email"].ToString();
                    id = Convert.ToInt32(r["ID"].ToString());
                }
            }

            MainView viewWindow = new MainView(nome,mail, id);
            viewWindow.Show();
            this.Close();
        }
    }
}
