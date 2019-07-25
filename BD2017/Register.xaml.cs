using System;
using System.Collections.Generic;
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
using System.Data.SqlClient;
using System.Data;

namespace BD2017
{
    /// <summary>
    /// Interaction logic for Register.xaml
    /// </summary>
    public partial class Register : Window
    {
        public Register()
        {
            InitializeComponent();
        }

        private void textBox2_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            MainWindow loginWindow = new MainWindow();
            loginWindow.Show();
            this.Close();
        }

        private void btnreg_Click(object sender, RoutedEventArgs e)
        {
            
            SqlConnection s = new SqlConnection("Data Source=LILITH;Initial Catalog=gamemasters;Integrated Security=True");
            s.Open();
            String email = txtemail.Text;
            String nome = txtname.Text;
            String username = txtUsername.Text;
            String password = txtpassword.Password;
            String addr = txtAddress.Text;
            DateTime dateBirth = date.DisplayDate;
            //String dateBirth = date.Text;

            using (var command = s.CreateCommand())
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "sp_createPerson";

                command.Parameters.AddWithValue("@Nome", nome);
                command.Parameters.AddWithValue("@dNascimento", dateBirth);
                command.Parameters.AddWithValue("@Endereço", addr);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception)
                {
                    MessageBox.Show("ERRO a criar utilizador", "ERRO", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
            }

            using (var command = s.CreateCommand())
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "sp_createUser";

                command.Parameters.AddWithValue("@Nome", nome);
                command.Parameters.AddWithValue("@Email", email);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception)
                {
                    MessageBox.Show("ERRO a criar utilizador", "ERRO", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
            }

            using (var command = s.CreateCommand())
            {
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "sp_createAccount";

                command.Parameters.AddWithValue("@NickName", username);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@pass", password);
                try
                {
                    command.ExecuteNonQuery();
                }
                catch (Exception)
                {
                    MessageBox.Show("ERRO a criar utilizador", "ERRO", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }
            }
            MessageBox.Show("Utilizador Criado", "Sucesso", MessageBoxButton.OK, MessageBoxImage.Information);
            MainWindow loginWindow = new MainWindow();
            loginWindow.Show();
            this.Close();
        }
    }
}
