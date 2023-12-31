<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ToFollowSuggestion.ascx.cs" Inherits="WebForms.SocialNetwork.Pages.HomeComponents.ToFollowSuggestion" %>


<asp:Repeater runat="server" ID="rptUsersSuggestion" OnItemCommand="rptUsersSuggestion_ItemCommand">
	<ItemTemplate>
		<div class="card">

			<div class="card-header pb-0 border-0">
				<h5 class="card-title mb-0">Users to follow</h5>
			</div>

			<div class="card-body">

				<div class="hstack gap-2 mb-3">

					<div class="avatar">
						<a  href="/u/<%# Eval("Username") %>">
							<img class="avatar-img rounded-circle" src="assets/images/avatar/04.jpg" alt=""></a>
					</div>

					<div class="overflow-hidden">
						<a class="h6 mb-0" href="/u/<%# Eval("Username") %>"><%# Eval("FirstName") %> <%# Eval("LastName") %></a>
						<p class="mb-0 small text-truncate"><%# Eval("Job") %></p>
					</div>

					<asp:LinkButton runat="server" CssClass="btn btn-primary-soft rounded-circle icon-md ms-auto"
						CommandName="AddFriend" CommandArgument='<%# Eval("UserID") %>'>
						<i class="bi bi-person-plus"></i>
					</asp:LinkButton>

				</div>

				<div class="d-grid mt-3">
					<a class="btn btn-sm btn-primary-soft" href="#!">View more</a>
				</div>

			</div>

		</div>
	</ItemTemplate>
</asp:Repeater>
