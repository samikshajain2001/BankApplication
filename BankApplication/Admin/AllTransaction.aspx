<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AllTransaction.aspx.cs" Inherits="BankApplication.Admin.AllTransaction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row" style="margin-top: 20px;">
            <h1 style="color:#007bff; text-align:center">All Transaction History</h1>
        </div>
        <div class="row">
            <div class="row" style="margin-top: 20px;">
            <div class="col-md-12" style="background-color: white; border: 1px solid #ddd; border-radius: 5px; padding: 15px;">
                <asp:GridView ID="gvLoadData" runat="server" CellPadding="4" CssClass="table table-striped table-bordered" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="TransactionID">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
            
                        <asp:BoundField DataField="TransactionID" HeaderText="TransactionID" InsertVisible="False" ReadOnly="True" SortExpression="TransactionID" />

                        <asp:BoundField DataField="AccountNumber" HeaderText="AccountNumber" SortExpression="AccountNumber" ReadOnly="True" />
                        <asp:BoundField DataField="TransactionType" HeaderText="TransactionType" SortExpression="TransactionType" ReadOnly="True" />
                        <asp:BoundField DataField="TransferAccountNumber" HeaderText="TransferAccountNumber" SortExpression="TransferAccountNumber" ReadOnly="True" />
                        <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" ReadOnly="True"/>
                        <asp:BoundField DataField="TransactionDate" HeaderText="TransactionDate" SortExpression="TransactionDate" ReadOnly="True" />

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
    </div>

</asp:Content>
