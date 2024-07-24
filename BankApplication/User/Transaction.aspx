<%@ Page Title="" Language="C#" MasterPageFile="~/User/UserMaster.Master" AutoEventWireup="true" CodeBehind="Transaction.aspx.cs" Inherits="BankApplication.User.Transaction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row" style="margin-top: 20px;">
            <h1 style="color:#007bff; text-align:center">Perform Transaction</h1>
        </div>
        <div class="row" style="margin-top: 20px;">
            <div class="col-12">
                <fieldset style="width: 50%; padding: 15px; border: 1px solid #007bff; border-radius: 5px; margin: auto;">
                    <legend style="width:auto; padding: 0 10px; color: #007bff">Add Account</legend>
                    <div >
                         <div class="form-group row" >
                            <label ID="lblAccountNumber" class="col-sm-5 text-center col-form-label"><b>Account Number:</b></label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtAccountNumber_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Display="Dynamic" runat="server" ErrorMessage="Account number is required" ControlToValidate="txtAccountNumber" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblNumberError" runat="server" Text="" Display="Dynamic" Visible="false"></asp:Label>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label ID="lblAmount" class="col-sm-5 text-center col-form-label"><b>Amount:</b></label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtAmount_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" ErrorMessage="Amount is required" ControlToValidate="txtAmount" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblAmountError" runat="server" Text="" Display="Dynamic" Visible="false"></asp:Label>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-sm-5 text-center col-form-label"><b>Transaction Type:</b></label>
                            <div class="col-sm-7">
                                <asp:DropDownList ID="ddlTransactionType" CssClass="form-control" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTransactionType_SelectedIndexChanged">
                                    <asp:ListItem Text="Select Transaction Type" Value="" />
                                    <asp:ListItem Text="Deposit" Value="Deposit"></asp:ListItem>
                                    <asp:ListItem Text="Withdraw" Value="Withdraw"></asp:ListItem>
                                    <asp:ListItem Text="Transfer" Value="Transfer"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Transaction Type is required" Display="Dynamic"  ControlToValidate="ddlTransactionType" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label ID="lblTargetAccount" runat="server" class="col-sm-5 text-center col-form-label" Visible="false"><b>Account for Transfer:</b></label>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txtTargetAccount" runat="server" CssClass="form-control" Visible="false" AutoPostBack="true" OnTextChanged="txtTargetAccount_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="Account number is required" ControlToValidate="txtTargetAccount" ForeColor="Red" CssClass="form-text text-danger" Visible="false"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblTargetNumberError" runat="server" Text="" Display="Dynamic" Visible="false"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-12 text-center ">
                                <asp:Label ID="lblTransactionError" runat="server" Display="Dynamic" Text="CGFDGDDG" Visible="false"></asp:Label>
                             </div>
                            <div class="col-sm-12 text-center ">
                                <asp:Button ID="btnSubmitTransaction" runat="server" CssClass="btn" style="background-color: #007bff; color: white; font-size: 20px; border-radius: 5px;" Text="Submit" OnClick="btnSubmitTransaction_Click" />
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>

        </div>

        <div class="row" style="margin-top: 20px;">
            <h1 style="color:#007bff; text-align:center">Transaction History</h1>
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
