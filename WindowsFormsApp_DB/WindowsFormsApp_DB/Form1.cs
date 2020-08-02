using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using DocumentFormat.OpenXml.CustomProperties;

namespace WindowsFormsApp_DB
{   
    

    public partial class Form1 : Form
    {

        //con.Open();

        //SqlCommand com = new SqlCommand();
        DataGridView DataGridView1 = new DataGridView();

        public Form1()
        {
            InitializeComponent();
            //con.ConnectionString=
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {

            string connetionString = null;
            SqlConnection cnn;
            connetionString = "Data Source=server name;Initial Catalog=BankProject;Integrated Security=True";
            cnn = new SqlConnection(connetionString);
           
            //SqlCommand cmd = new SqlCommand("select * from Customer_validation");
            //com.CommandText = "select * from Customer_validation";
            //SqlDataReader dr = com.ExecuteReader();
            try {
                cnn.Open();
                //MessageBox.Show("Connection Open ! ");
                SetupDataGridView();
                DataTable mytable = new DataTable();
                SqlCommand cmd = new SqlCommand("select * from Customer_validation", cnn);
                //DataGridView DataGridView1 = new DataGridView();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                //sda.SelectCommand = cmd;
                sda.Fill(mytable);
                BindingSource bsource = new BindingSource();
                bsource.DataSource = mytable;
                DataGridView1.DataSource = bsource;
                sda.Update(mytable);
                cnn.Close();
            }

            catch(Exception x)
            {
                MessageBox.Show(x.Message);
            }
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string connetionString = null;
            SqlConnection cnn;
            connetionString = "Data Source=ZEHTAB-QT724IR;Initial Catalog=BankProject;Integrated Security=True";
            cnn = new SqlConnection(connetionString);

            //SqlCommand cmd = new SqlCommand("select * from Customer_validation");
            //com.CommandText = "select * from Customer_validation";
            //SqlDataReader dr = com.ExecuteReader();
            try
            {
                cnn.Open();
                //MessageBox.Show("Connection Open ! ");
                SetupDataGridView();
                DataTable mytable = new DataTable();
                int num;
                num = int.Parse(textBox1.Text);
                SqlCommand cmd = new SqlCommand("TrnGraph", cnn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@vID", num));
                //SqlDataReader dr = cmd.ExecuteReader();
                //DataGridView DataGridView1 = new DataGridView();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                //sda.SelectCommand = cmd;
                sda.Fill(mytable);
                BindingSource bsource = new BindingSource();
                bsource.DataSource = mytable;
                DataGridView1.DataSource = bsource;
                sda.Update(mytable);
                cnn.Close();
            }

            catch (Exception x)
            {
                MessageBox.Show(x.Message);
            }

        }

        private void SetupDataGridView()
        {
            this.Controls.Add(DataGridView1);

            //songsDataGridView.ColumnCount = 5;

            DataGridView1.ColumnHeadersDefaultCellStyle.BackColor = Color.Navy;
            DataGridView1.ColumnHeadersDefaultCellStyle.ForeColor = Color.White;
            DataGridView1.ColumnHeadersDefaultCellStyle.Font =
                new Font(DataGridView1.Font, FontStyle.Bold);
            DataGridView1.Name = "Valiation";
            DataGridView1.Location = new Point(8, 8);
            DataGridView1.Size = new Size(1050, 300);
            DataGridView1.AutoSizeRowsMode =
                DataGridViewAutoSizeRowsMode.DisplayedCellsExceptHeaders;
            DataGridView1.ColumnHeadersBorderStyle =
                DataGridViewHeaderBorderStyle.Single;
            DataGridView1.CellBorderStyle = DataGridViewCellBorderStyle.Single;
            DataGridView1.GridColor = Color.Black;
            DataGridView1.RowHeadersVisible = false;
        }

        private void textBox1_TextChanged_1(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            string connetionString = null;
            SqlConnection cnn;
            connetionString = "Data Source=ZEHTAB-QT724IR;Initial Catalog=BankProject;Integrated Security=True";
            cnn = new SqlConnection(connetionString);
            try
            {
                cnn.Open();
                MessageBox.Show("Connection Open ! ");
                cnn.Close();
            }

            catch (Exception x)
            {
                MessageBox.Show(x.Message);
            }
        }
    }
}
