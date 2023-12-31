<%@ Page Title="Register" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebForms.SocialNetwork.Pages.Auth.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<main class="form-signin d-flex flex-column justify-content-center w-50 m-auto">
		<h1 class="h3 mb-3 fw-normal">Create a new account</h1>

		<div class="d-flex flex-column gap-4">

			<div class="row">

				<div class="col">

					<div class="form-floating">
						<asp:TextBox runat="server" CssClass="form-control" ID="textBox_FirstName" placeholder="" />
						<label for="textBox_FirstName">First Name</label>
					</div>

				</div>

				<div class="col">

					<div class="form-floating">
						<asp:TextBox runat="server" CssClass="form-control" ID="textBox_LastName" placeholder="" />
						<label for="textBox_LastName">Last Name</label>
					</div>

				</div>

			</div>

			<div class="row">

				<div class="col">

					<div class="form-floating w-100">
						<asp:TextBox runat="server" CssClass="form-control" ID="textBox_Username" placeholder="" />
						<label for="textBox_Username">Username</label>
					</div>

				</div>

				<div class="col">

					<div class="form-floating w-100">
						<asp:TextBox runat="server" CssClass="form-control" ID="textBox_Birthdate" placeholder="" TextMode="Date" />
						<label for="textBox_Birthdate">Birthdate</label>
					</div>

				</div>

			</div>

			<div class="form-floating w-100">
				<asp:TextBox runat="server" CssClass="form-control" ID="textBox_Email" placeholder="" TextMode="Email" />
				<label for="textBox_Email">Email address</label>
			</div>

			<div class="form-floating w-100">
				<asp:TextBox runat="server" CssClass="form-control" ID="textBox_Password" placeholder="" TextMode="Password" />
				<label for="textBox_Password">Password</label>
			</div>

			<asp:Button runat="server" CssClass="btn btn-primary" Text="Register" ID="Btn_Register" OnClick="Btn_Register_Click" />

		</div>

	</main>
</asp:Content>
