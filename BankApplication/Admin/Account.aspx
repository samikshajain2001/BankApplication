<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="BankApplication.Admin.Account" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row" style="margin-top: 20px">
            <div class="col-md-12 text-right">
                <asp:Button ID="btnAddAccount" runat="server" CausesValidation="false" CssClass="btn btn-primary btn-lg" Text="Add Account" OnClick="btnAddAccount_Click" />
            </div>
            <div class="col-md-12 text-right">
                <asp:Label ID="lblSuccess" CssClass="text-success" runat="server"></asp:Label>
            </div>
        </div>

    
        <div class="row" style="margin-top: 20px" runat="server" id="form" visible="false">  
            <div class="col-12">
                <fieldset style="width: 50%; padding: 15px; border: 1px solid #007bff; border-radius: 5px; margin: auto;">
                    <legend style="width:auto; padding: 0 10px; color: #007bff">Add Account</legend>
                    <div >
                         <div class="form-group row" >
                            <label class="col-sm-3 text-center col-form-label"><b>User Name of Client1:</b></label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txtClient1" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Client name is required" Display="Dynamic"  ControlToValidate="txtClient1" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                            </div>
                             <div class="col-sm-3">
                                <asp:Button ID="btnSearchClient1" runat="server" CssClass="form-control" Text="Search Client" OnClick="btnSearchClient1_Click" />
                                <asp:Label ID="lblClient1Error" runat="server" Display="Dynamic"  ForeColor="Red" Visible="false"></asp:Label>
                            </div>
                        </div>
                        
                        <div class="form-group row">
                            <label class="col-sm-3 text-center col-form-label"><b>User Name of Client2:</b></label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txtClient2" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-sm-3">
                                <asp:Button ID="btnSearchClient2" runat="server" CssClass="form-control" Text="Search Client" OnClick="btnSearchClient2_Click" />
                                <asp:Label ID="lblClient2Error" runat="server" Display="Dynamic"  ForeColor="Red" Visible="false"></asp:Label><br />
                            </div>
                        </div>

                        <div class="form-group row">
                            <label class="col-sm-3 text-center col-form-label"><b>Current Balance:</b></label>
                            <div class="col-sm-6">
                                <asp:TextBox ID="txtBalance" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-12 text-center ">
                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn" style="background-color: #007bff; color: white; font-size: 20px; border-radius: 5px;" Text="Submit" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>

        <div class="row" style="margin-top: 20px;">
            <div class="col-md-12" style="background-color: white; border: 1px solid #ddd; border-radius: 5px; padding: 15px;">
                <asp:GridView ID="gvLoadData" runat="server" CellPadding="4" CssClass="table table-striped table-bordered" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="AccountID" OnRowCancelingEdit="gvLoadData_RowCancelingEdit" OnRowDeleting="gvLoadData_RowDeleting" OnRowEditing="gvLoadData_RowEditing" OnRowUpdating="gvLoadData_RowUpdating">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
            
                        <asp:BoundField DataField="AccountID" HeaderText="AccountID" InsertVisible="False" ReadOnly="True" SortExpression="AccountID" />

                        <asp:BoundField DataField="AccountNumber" HeaderText="AccountNumber" SortExpression="AccountNumber" ReadOnly="True"/>
                        <asp:BoundField DataField="Balance" HeaderText="Balance" SortExpression="Balance" />
                        <asp:BoundField DataField="Client1FullName" HeaderText="Client1FullName" SortExpression="Client1FullName" ReadOnly="True"/>
                        <asp:BoundField DataField="Client2FullName" HeaderText="Client2FullName" SortExpression="Client2FullName" ReadOnly="True"/>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />

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
