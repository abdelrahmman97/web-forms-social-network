<%@ Page Title="Profile" Language="C#" MasterPageFile="~/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WebForms.SocialNetwork.Pages.User.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

	<div class="row g-4">

		<div class="col-lg-8 vstack gap-4">

			<div class="card">

				<div class="h-200px rounded-top" runat="server" id="imgCover"
					style="background-image: url('Assets/Images/Cover/cover.jpg'); background-position: center; background-size: cover; background-repeat: no-repeat;">
				</div>

				<div class="card-body py-0">

					<div class="d-sm-flex align-items-center text-center text-sm-center">

						<%-- Avatar --%>
						<div>
							<div class="avatar avatar-xxl mb-3 mt-n5 position-relative">
								<img class="avatar-img rounded-circle border border-white border-3" runat="server" id="imgAvatar"
									src="https://github.com/mdo.png" alt="">
								<div class="avatar-fileInput-container">
									<asp:FileUpload runat="server" ID="fileUploadAvatar" ClientIDMode="Static" CssClass="hiding visually-hidden" AllowMultiple="false" />
									<label runat="server" for="fileUploadAvatar" class="border-1 border-white btn btn-primary icon-sm rounded-circle">
										<i class="bi bi-camera"></i>
									</label>
								</div>
							</div>
						</div>
						<%--<input runat="server" id="avatarInput" type="file" title="avatarFileInput" class="hiding visually-hidden" style="width: 0; height: 0;" on />--%>

						<%-- User Full Name --%>
						<div class=" ms-sm-4 mt-sm-3 text-start">
							<h1 class="mb-0 h5">
								<asp:Label runat="server" ID="lblFirstName" />
								<asp:Label runat="server" ID="lblLastName" />
								<i id="verifiedIcon" runat="server" class='bi bi-patch-check-fill text-primary small'></i>
							</h1>
							<p>250 Friends</p>
						</div>

						<%-- Options --%>
						<div class="d-flex mt-3 justify-content-center ms-sm-auto">

							<%if ( ShowFollowButton() )
								{
									if ( CheckFollowStatus() )
									{ %>
							<asp:LinkButton runat="server" CssClass="btn btn-dark-soft me-2" ID="Btn_UnFollow" OnClick="Btn_UnFollow_Click">
								<i class="bi bi-person-dash-fill"></i>
								Unfollow
							</asp:LinkButton>
							<% }
								else
								{%>
							<asp:LinkButton runat="server" CssClass="btn btn-primary-soft me-2" ID="Btn_Follow" OnClick="Btn_Follow_Click">
								<i class="bi bi-person-plus-fill"></i>
								Follow
							</asp:LinkButton>
							<%}
								}%>
							<div class="dropdown">

								<button class="icon-md btn btn-light" type="button" id="profileAction2" data-bs-toggle="dropdown" aria-expanded="false">
									<i class="bi bi-three-dots"></i>
								</button>

								<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileAction2">
									<li><a class="dropdown-item" href="#"><i class="bi bi-bookmark fa-fw pe-2"></i>Share profile in a message</a></li>
									<li><a class="dropdown-item" href="#"><i class="bi bi-file-earmark-pdf fa-fw pe-2"></i>Save your profile to PDF</a></li>
									<li><a class="dropdown-item" href="#"><i class="bi bi-lock fa-fw pe-2"></i>Lock profile</a></li>
									<li>
										<hr class="dropdown-divider">
									</li>
									<li><a class="dropdown-item" href="#"><i class="bi bi-gear fa-fw pe-2"></i>Profile settings</a></li>
								</ul>

							</div>

						</div>

					</div>

					<!-- User details -->
					<ul class="list-inline mb-0 text-center text-sm-start mt-3 mt-sm-0">
						<li class='list-inline-item' runat="server" id="li_Job">
							<i class='bi bi-geo-alt me-1'></i>
							<asp:Label runat="server" ID="lblJob" />
						</li>
						<li class='list-inline-item' runat="server" id="li_Country">
							<i class='bi bi-geo-alt me-1'></i>
							<asp:Label runat="server" ID="lblCountry" />
						</li>
						<li class="list-inline-item">
							<i class="bi bi-calendar2-plus me-1"></i>
							Joined on
							<asp:Label runat="server" ID="lblRegistrationDate" />
						</li>
					</ul>

				</div>

				<!-- Nav profile pages -->
				<div class="card-footer mt-3 pt-2 pb-0">
					<ul class="nav nav-bottom-line align-items-center justify-content-center justify-content-md-start mb-0 border-0 gap-4">
						<li class="nav-item"><a class="nav-link px-0 active" href="my-profile.html">Posts </a></li>
						<li class="nav-item"><a class="nav-link px-0" href="my-profile-about.html">About </a></li>
						<li class="nav-item"><a class="nav-link px-0" href="my-profile-connections.html">Connections <span class="badge bg-success bg-opacity-10 text-success small">230</span> </a></li>
						<li class="nav-item"><a class="nav-link px-0" href="my-profile-media.html">Media</a> </li>
						<li class="nav-item"><a class="nav-link px-0" href="my-profile-videos.html">Videos</a> </li>
						<li class="nav-item"><a class="nav-link px-0" href="my-profile-events.html">Events</a> </li>
						<li class="nav-item"><a class="nav-link px-0" href="my-profile-activity.html">Activity</a> </li>
					</ul>
				</div>

			</div>

		</div>

		<div class="col-lg-4">

			<!-- About section -->
			<div class="card">

				<div class="card-header border-0 pb-0">
					<h5 class="card-title">About</h5>
				</div>

				<div class="card-body position-relative pt-0">

					<asp:Label runat="server" ID="lblAbout" />

					<ul class="list-unstyled mt-3 mb-0">
						<li class="mb-2" runat="server" id="li_DateOfBirth">
							<i class="bi bi-calendar-date fa-fw pe-1"></i>
							Born: <strong>
								<asp:Label runat="server" ID="lblDateOfBirth" /></strong>
						</li>
						<li class='mb-2' runat="server" id="li_Gender">
							<i class="bi bi-gender-ambiguous fa-fw pe-1"></i>
							Gender: <strong>
								<asp:Label runat="server" ID="lblGender" /></strong>
						</li>
						<li class='mb-2' runat="server" id="li_Email">
							<i class='bi bi-envelope fa-fw pe-1'></i>
							Email: <strong>
								<asp:Label runat="server" ID="lblEmail" /></strong>
						</li>
					</ul>
				</div>

			</div>

		</div>

	</div>

</asp:Content>
