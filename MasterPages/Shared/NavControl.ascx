<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavControl.ascx.cs" Inherits="WebForms.SocialNetwork.MasterPages.Shared.NavControl" %>

<nav class="navbar navbar-expand-sm navbar-toggleable-sm bg-mode">
	<div class="container">
		<a class="navbar-brand" runat="server" href="~/">Application name</a>
		<button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target=".navbar-collapse" title="Toggle navigation" aria-controls="navbarSupportedContent"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse d-sm-inline-flex justify-content-between">
			<ul class="navbar-nav flex-grow-1">
				<li class="nav-item"><a class="nav-link" runat="server" href="~/">Home</a></li>
				<li class="nav-item"><a class="nav-link" runat="server" href="~/About">About</a></li>
				<li class="nav-item"><a class="nav-link" runat="server" href="~/Contact">Contact</a></li>
			</ul>
			<% if ( Session[ "UserID" ] == null )
				{ %>
			<ul class="navbar-nav">
				<li class="nav-item"><a class="btn btn-outline-primary me-2" runat="server" href="~/login">Login</a></li>
				<li class="nav-item"><a class="btn btn-primary" runat="server" href="~/register">Register</a></li>
			</ul>
			<%} %>
			<% else
				{%>
			<ul class="navbar-nav">
				<%-- Search --%>
				<li class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
					<input type="search" class="form-control" placeholder="Search..." aria-label="Search">
				</li>

				<%-- User Dropdown --%>
				<li class="dropdown text-end">
					<a href="#" class="d-block link-body-emphasis text-decoration-none dropdown-toggle"
						data-bs-toggle="dropdown" aria-expanded="false">
						<img src="/Assets/Images/Avatar/avatar1.jpg" alt="mdo" width="32" height="32" class="rounded-circle">
					</a>
					<ul class="dropdown-menu dropdown-menu-lg-end text-small p-2 rounded-3 mx-0 shadow w-220px">
						<li>
							<a class="dropdown-item btn-primary-soft-hover rounded-2" href="<%= ResolveUrl("~/u/"+ Session[ "Username" ]) %>">
								<i class="bi bi-person me-2"></i>
								Profile
							</a>
						</li>
						<li>
							<a class="dropdown-item btn-primary-soft-hover rounded-2" href="#">
								<i class="bi bi-gear fa-fw me-2"></i>
								Settings
							</a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>
						<li>
							<asp:LinkButton runat="server" CssClass="btn btn-danger-soft-hover border-0 w-100 rounded-2 text-start" ID="Btn_SignOut" OnClick="Btn_SignOut_Click">
								<i class="bi bi-power fa-fw me-2"></i>
								Sign out
							</asp:LinkButton>
						</li>
					</ul>
				</li>
			</ul>
			<%} %>
		</div>
	</div>
</nav>
