<%@ Page Title="" Language="C#" MasterPageFile="~/User/UserMaster.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BankApplication.User.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row" style="margin-top: 20px;">
            <h2>Welcome, <asp:Label ID="lblClientName" runat="server" Text=""></asp:Label></h2>
        </div>
        <div class="row" style="margin-top: 20px;">
            <h3 style="color:#007bff; text-align:center">Account Information</h3>
        </div>

        <div class="row" style="margin-top: 20px;">
            <div class="col-md-12" style="background-color: white; border: 1px solid #ddd; border-radius: 5px; padding: 15px;">
                <asp:GridView ID="gvAccounts" runat="server" AutoGenerateColumns="False" CssClass="table table-striped" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="AccountID" HeaderText="Account ID" ReadOnly="True" />
                        <asp:BoundField DataField="AccountNumber" HeaderText="Account Number" ReadOnly="True" />
                        <asp:BoundField DataField="Balance" HeaderText="Balance" ReadOnly="True" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
            </div>
        </div>
        
        

        
        
    </div>

</asp:Content>
