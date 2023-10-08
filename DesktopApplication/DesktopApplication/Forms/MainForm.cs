﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Diagnostics;
using DesktopApplication.Forms;
using DesktopApplication.Classes;
using DesktopApplication.Models;
using System.Runtime.InteropServices;

namespace DesktopApplication.Forms
{
    
    public partial class MainForm : Form
    {
        public string user;
        private Button currentButton;
        private Form activeForm;
        public MainForm()
        {
            InitializeComponent();
        }

        public MainForm(string fullname)
        {
            InitializeComponent();
            user = fullname;    
        }
        private void MainForm_Load(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString();
            this.Text = string.Empty;
            this.ControlBox = false;
            UserLabel.Text = user;
            
        }

        [DllImport("user32.dll", EntryPoint = "ReleaseCapture")]
        private extern static void ReleaseCapture();
        [DllImport("user32.dll", EntryPoint = "SendMessage")]
        private extern static void SendMessage(IntPtr hWnd,int wMsg,int wParam,int lParam);


        private void OpenChildForm(Form cForm , object btnSender)
        {
            if(activeForm != null)
            {
                activeForm.Close();
            }
            activeForm= cForm;
            ActiveButton(btnSender);
            cForm.TopLevel = false;
            cForm.FormBorderStyle = FormBorderStyle.None;
            cForm.Dock = DockStyle.Fill;
            pnlMainForm.Controls.Add(cForm);
            pnlMainForm.Tag = cForm;
            cForm.BringToFront();
            cForm.Show();
        }



        private Color SelectTheme()
        {
            if (currentButton.Text == "Point Of Sale")
            {
                return Color.Gray;
            }
            else if (currentButton.Text == "Setup")
            {
                return Color.Red;
            }
            else if (currentButton.Text == "Reporting")
            {
                return Color.Blue;
            }
            else if (currentButton.Text == "Options")
            {
                return Color.Green;
            }
            else
            {
                return Color.Gray;
            };
        }

        private void ActiveButton(object sender) 
        {
            if(sender != null)
            {
                if(currentButton != (Button)sender) 
                {
                    unSelectButton();
                    currentButton = (Button)sender;
                    Color color= SelectTheme(); 
                    currentButton.BackColor = color;
                    currentButton.ForeColor = Color.White;
                    currentButton.Font = new Font("Tohoma",11F,FontStyle.Bold);
                    pnlTitle.BackColor= color;
                    lblTitle.Text = currentButton.Text;

                }
            }
        }

        private void unSelectButton()
        {
            foreach(Control ctr in pnlMenu.Controls)
            {
                if(ctr.GetType()== typeof(Button))
                {
                    ctr.BackColor = Color.Gray;
                    ctr.ForeColor = Color.White;
                    ctr.Font = new Font("Tohoma", 8F, FontStyle.Regular);
                }
            }
        }

        private void btnPOS_Click(object sender, EventArgs e)
        {
            OpenChildForm(new MainPointOfSale(), sender);
        }

        private void btnSetup_Click(object sender, EventArgs e)
        {
            OpenChildForm(new MainSetup(), sender);

        }

        private void btnReporting_Click(object sender, EventArgs e)
        {
            OpenChildForm(new MainReports(), sender);

        }

        private void btnOptions_Click(object sender, EventArgs e)
        {
            OpenChildForm(new MainOptions(), sender);

        }

        

        private void timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString();
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            Process.Start("https://www.youtube.com/");
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        public void loadPermission(Control.ControlCollection controls,string mainscreeen)
        {
            SmartPOSEntities smartPOSData = new SmartPOSEntities();
            foreach (Control control in controls)
            {
                for(int i=0;i<control.Controls.Count; i++)
                {

                    var model=declarations.permissions.Where(x=> x.mainScreeen==mainscreeen
                                                                 && x.permission == control.Controls[i].AccessibleName).FirstOrDefault();
                
                    if(model!=null)
                        control.Controls[i].Enabled=(bool)model._case;

                }
            }
        }

        private void pnlMenu_Paint(object sender, PaintEventArgs e)
        {
            loadPermission(this.Controls, "Main");
        }

        private void pnlTitle_MouseDown(object sender, MouseEventArgs e)
        {
            ReleaseCapture();
            SendMessage(this.Handle,0x112,0xf012,0);
        }

      
    }
}
