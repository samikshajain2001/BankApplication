<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BankApplication.Admin.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row" style="margin-top: 20px">
            <h2>Welcome, Admin</h2>
            <div class="col-md-12 text-right">
                <asp:Button ID="btnAddClient" runat="server" CausesValidation="false" CssClass="btn btn-primary btn-lg" Text="Add Client" OnClick="btnAddClient_Click" />
            </div>
            <div class="col-md-12 text-right">
                <asp:Label ID="lblSuccess" CssClass="text-success" runat="server"></asp:Label>
            </div>
        </div>

    
        <div class="row" style="margin-top: 20px" runat="server" id="form" visible="false">  
            <div class="col-12">
                <fieldset style="width: 50%; padding: 15px; border: 1px solid #007bff; border-radius: 5px; margin: auto;">
                    <legend style="width:auto; padding: 0 10px; color: #007bff">Add Client</legend>
                    <form >
                        <div class="form-group row" >
                            <label class="col-sm-4 text-center col-form-label"><b>User Name:</b></label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"  ErrorMessage="User name is required" ControlToValidate="txtUserName" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblExist" Display="Dynamic"  runat="server" CssClass="form-text"></asp:Label>
                            </div>
                        </div>
                        <div class="form-group row" >
                            <label class="col-sm-4 text-center col-form-label"><b>Password:</b></label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password is required" Display="Dynamic"  ControlToValidate="txtPassword" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                         <div class="form-group row" >
                            <label class="col-sm-4 text-center col-form-label"><b>First Name:</b></label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="First name is required" Display="Dynamic"  ControlToValidate="txtFirstName" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-4 text-center col-form-label"><b>Last Name:</b></label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Last name is required" Display="Dynamic"  ControlToValidate="txtLastName" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-4 text-center col-form-label"><b>Email:</b></label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Email is required" ControlToValidate="txtEmail" Display="Dynamic" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Please enter a valid email." ControlToValidate="txtEmail" Display="Dynamic"  ValidationExpression="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" ForeColor="Red" CssClass="form-text text-danger"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-4 text-center col-form-label"><b>Phone:</b></label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Phone Number is required" Display="Dynamic"  ControlToValidate="txtPhone" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label class="col-sm-4 text-center col-form-label"><b>Address:</b></label>
                            <div class="col-sm-8">
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Address is required" Display="Dynamic"  ControlToValidate="txtAddress" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-12 text-center ">
                                <asp:Button ID="btnSubmit" runat="server" CssClass="btn" style="background-color: #007bff; color: white; font-size: 20px; border-radius: 5px;" Text="Submit" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </form>
                </fieldset>
            </div>
        </div>

        <div class="row" style="margin-top: 20px;">
            <div class="col-md-12" style="background-color: white; border: 1px solid #ddd; border-radius: 5px; padding: 15px;">
                <asp:GridView ID="gvLoadData" runat="server" CellPadding="4" CssClass="table table-striped table-bordered" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" DataKeyNames="ClientID" OnRowCancelingEdit="gvLoadData_RowCancelingEdit" OnRowDeleting="gvLoadData_RowDeleting" OnRowEditing="gvLoadData_RowEditing" OnRowUpdating="gvLoadData_RowUpdating">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
            
                        <asp:BoundField DataField="ClientID" HeaderText="ClientID" InsertVisible="False" ReadOnly="True" SortExpression="ClientID" />
                        <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" ReadOnly="True" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
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
