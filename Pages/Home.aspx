<%@ Page Title="Home" Language="C#" MasterPageFile="~/MasterPages/SiteHome.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebForms.SocialNetwork.Pages.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HomeContent" runat="server">

	<%--post form--%>
	<div class="card card-body">

		<div class="d-flex mb-3">

			<div class="avatar avatar-xs me-2">
				<a href="#">
					<img class="avatar-img rounded-circle" src="/Assets/Images/Avatar/avatar1.jpg" alt="">
				</a>
			</div>

			<div class="d-flex flex-column w-100">
				<asp:TextBox runat="server" ID="textBox_Post" CssClass="form-control pe-4 border-0"
					TextMode="MultiLine" Rows="3" AutoPostBack="false" placeholder="Share your thoughts..."
					MaxLength="300" oninput="updateCharacterLimit()" />
			</div>
		</div>

		<ul class="nav nav-pills nav-stack small fw-normal">
			<li class="nav-item">
				<a class="nav-link bg-light py-1 px-2 mb-0" href="#!" data-bs-toggle="modal" data-bs-target="#feedActionPhoto">
					<i class="bi bi-image-fill text-success pe-2"></i>
					Photo
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link bg-light py-1 px-2 mb-0" href="#!" data-bs-toggle="modal" data-bs-target="#feedActionVideo">
					<i class="bi bi-camera-reels-fill text-info pe-2"></i>
					Video
				</a>
			</li>
			<li class="nav-item dropdown ms-lg-auto">
				<div class="d-flex flex-row align-items-center gap-2">
					<asp:Label runat="server" ID="CharLimit" Text="300" CssClass="fs-6" />
					<hr class="vr text-black" style="width: 2px; height: 25px;" />
					<asp:LinkButton runat="server" class="nav-link text-bg-primary py-1 px-2 mb-0" ID="Btn_Post" OnClick="Btn_Post_Click">
								<i class="bi bi-send-fill"></i>
					</asp:LinkButton>
				</div>
			</li>
		</ul>

	</div>

	<%--posts list--%>
	<asp:Repeater runat="server" ID="rptPosts">
		<ItemTemplate>
			<div>
				<div class="card">

					<div class="card-header border-0 pb-0">
						<div class="d-flex align-items-center justify-content-between">
							<div class="d-flex align-items-center">
								<div class="avatar me-2">
									<a href="#">
										<img class="avatar-img rounded-circle" src="/Assets/Images/Avatar/avatar1.jpg" alt="">
									</a>
								</div>
								<div>
									<h6 class="card-title mb-0">
										<a href="<%# GetRouteUrl("Profile", new {Username = Eval("Username")}) %>">
											<%# Eval("FirstName") %> <%# Eval("LastName") %>

										</a>
									</h6>
									<p class="mb-0 small" id="post<%# Container.ItemIndex+1 %>">
										<script>
											$( "#post" +<%# Container.ItemIndex+1 %>+"" ).text( TimeUtils.fromNow( new Date( "<%# Eval("PostDate", "{0:yyyy-MM-dd HH:mm:ss}") %>" ) ) );
											setInterval(
												function ()
												{
													$( "#post" +<%# Container.ItemIndex+1 %>+"" ).text( TimeUtils.fromNow( new Date( "<%# Eval("PostDate", "{0:yyyy-MM-dd HH:mm:ss}") %>" ) ) );
													<%--document.getElementById( "post" +<%# Container.ItemIndex+1 %>+"" ).innerHTML = TimeUtils.fromNow( new Date( "<%# Eval("PostDate", "{0:yyyy-MM-dd HH:mm:ss}") %>" ) );--%>
												}, 60000
											);
										</script>
										<%--<%# Eval("PostDate", "{0:yyyy-MM-dd HH:mm:ss}") %>--%>
									</p>
								</div>
							</div>
							<a href="#" class="text-secondary btn btn-secondary-soft-hover py-1 px-2" id="cardShareAction5" data-bs-toggle="dropdown" aria-expanded="false">
								<i class="bi bi-three-dots"></i>
							</a>
							<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="cardShareAction5" style="">
								<%# DisplayPostDropdownOptions( Eval( "UserID" ) ) %>
							</ul>
						</div>
					</div>

					<div class="card-body pb-0">
						<p class="text-break">
							<%# Eval("Content") %>
						</p>
						<ul class="nav nav-stack pb-2 small">
							<li class="nav-item">
								<a class="nav-link active text-secondary" href="#!">
									<i class="bi bi-heart-fill me-1 bg-danger text-white rounded-circle p-1"></i>
									Louis, Billy and 126 others
								</a>
							</li>
							<li class="nav-item ms-sm-auto">
								<a class="nav-link" href="#!">
									<i class="bi bi-chat-fill pe-1"></i>
									Comments (12)
								</a>
							</li>
						</ul>
					</div>

					<div class="card-footer py-3">

						<ul class="nav nav-fill nav-stack small">
							<li class="nav-item">
								<a class="nav-link mb-0" href="#!">
									<i class="bi bi-heart pe-1"></i>
									Like (<%# Eval("LikesCount") %>)
								</a>
							</li>

							<li class="nav-item dropdown">
								<a href="#" class="nav-link mb-0" id="cardShareAction6" data-bs-toggle="dropdown" aria-expanded="false">
									<i class="bi bi-reply-fill flip-horizontal ps-1"></i>
									Share (3)
								</a>

								<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="cardShareAction6">
									<li><a class="dropdown-item" href="#"><i class="bi bi-envelope fa-fw pe-2"></i>Send via Direct Message</a></li>
									<li><a class="dropdown-item" href="#"><i class="bi bi-bookmark-check fa-fw pe-2"></i>Bookmark </a></li>
									<li><a class="dropdown-item" href="#"><i class="bi bi-link fa-fw pe-2"></i>Copy link to post</a></li>
									<li><a class="dropdown-item" href="#"><i class="bi bi-share fa-fw pe-2"></i>Share post via …</a></li>
									<li>
										<hr class="dropdown-divider">
									</li>
									<li><a class="dropdown-item" href="#"><i class="bi bi-pencil-square fa-fw pe-2"></i>Share to News Feed</a></li>
								</ul>
							</li>

							<li class="nav-item">
								<a class="nav-link mb-0" href="#!"><i class="bi bi-send-fill pe-1"></i>Send</a>
							</li>
						</ul>

					</div>

					<%--<strong><%# Eval("Username") %></strong>: <%# Eval("Content") %>
								<br />
								<small><%# Eval("PostDate", "{0:yyyy-MM-dd HH:mm:ss}") %></small>
								<!-- Add buttons for edit and delete if the post belongs to the logged-in user -->
								<asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CommandArgument='<%# Eval("PostID") %>' />
								<asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CommandArgument='<%# Eval("PostID") %>' />--%>
				</div>
			</div>
		</ItemTemplate>
	</asp:Repeater>


	<script type="text/javascript">
		function updateCharacterLimit()
		{
			var textBox = document.getElementById('<%= textBox_Post.ClientID %>' );
			var charLimitLabel = document.getElementById('<%= CharLimit.ClientID %>' );
			var remainingChars = textBox.maxLength - textBox.value.length;
			charLimitLabel.innerText = remainingChars.toString();
			if ( remainingChars == 0 ) charLimitLabel.style.color = "Red";
		}
	</script>


</asp:Content>
