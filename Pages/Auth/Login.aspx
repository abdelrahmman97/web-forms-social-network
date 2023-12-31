<%@ Page Title="Login" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" 
	CodeBehind="Login.aspx.cs" Inherits="WebForms.SocialNetwork.Pages.Auth.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<main class="form-signin d-flex flex-column justify-content-center h-100 w-25 m-auto">

		<h1 class="h3 mb-3 fw-normal">Please sign in</h1>

		<div class="d-flex flex-column gap-4">

			<div class="form-floating">
				<asp:TextBox runat="server" CssClass="form-control" ID="textBox_Email" TextMode="Email" placeholder="" />
				<label for="floatingInput">Email address</label>
			</div>

			<div class="form-floating">
				<asp:TextBox runat="server" CssClass="form-control" ID="textBox_Password" TextMode="Password" placeholder="" />
				<label for="floatingPassword">Password</label>
			</div>

			<asp:Button runat="server" CssClass="btn btn-primary py-2" ID="Btn_SignIn" OnClick="Btn_SignIn_Click" Text="Sign in" />

		</div>

	</main>
</asp:Content>
