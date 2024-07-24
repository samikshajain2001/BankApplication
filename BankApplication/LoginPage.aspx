<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="BankApplication.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body, html {
            height: 80%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row" style="margin-top: 20px;">
                <div class="col-12">
                    <fieldset style="width: 100%; padding: 15px; border: 1px solid #007bff; border-radius: 5px; margin: auto;">
                        <legend style="width:auto; padding: 0 10px; color: #007bff">Login</legend>
                        <div >
                            <div class="row" >
                                <asp:Label class="col-sm-12 col-form-label" ID="lblError" runat="server" Text=""></asp:Label>
                            </div>
                             <div class="form-group row" >
                                <label  id="lblUserName" class="col-sm-5 text-center col-form-label"><b>User Name:</b></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="User Name is required" ControlToValidate="txtUserName" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        
                            <div class="form-group row">
                                <label id="lblPassword" class="col-sm-5 text-center col-form-label"><b>Password:</b></label>
                                <div class="col-sm-7">
                                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Password is required" ControlToValidate="txtPassword" ForeColor="Red" CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="form-group row">
                                <div class="col-sm-12 text-center ">
                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn" style="background-color: #007bff; color: white; font-size: 20px; border-radius: 5px;" Text="Submit" OnClick="btnSubmit_Click"  />
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>

            </div>
        </div>


    </form>



</body>
</html>
