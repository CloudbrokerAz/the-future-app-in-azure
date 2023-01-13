#!/bin/bash
# Script to deploy a very simple web application.
# The web app has a customizable image and some text.

cat << EOM > /var/www/html/index.html
<!DOCTYPE HTML>
<!--
	Landed by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>${PREFIX^} Future</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload landing">
		<div id="page-wrapper">

			<!-- Header -->
				<header id="header">
					<h1 id="logo"><a href="index.html">Infrastructure enables innovation</a></h1>
					<nav id="nav">
						<ul>
							<li><a href="index.html">Home</a></li>
							<li>
								<a href="#">Layouts</a>
								<ul>
									<li><a href="left-sidebar.html">Left Sidebar</a></li>
									<li><a href="right-sidebar.html">Right Sidebar</a></li>
									<li><a href="no-sidebar.html">No Sidebar</a></li>
									<li>
										<a href="#">Submenu</a>
										<ul>
											<li><a href="#">Option 1</a></li>
											<li><a href="#">Option 2</a></li>
											<li><a href="#">Option 3</a></li>
											<li><a href="#">Option 4</a></li>
										</ul>
									</li>
								</ul>
							</li>
							<li><a href="elements.html">Elements</a></li>
							<li><a href="#" class="button primary">Sign Up</a></li>
						</ul>
					</nav>
				</header>

			<!-- Banner -->
				<section id="banner">
					<div class="content">
						<header>
							<h2>${PREFIX^} the future has landed in region: ${LOCATION^^}</h2>
							<p>And there are no hoverboards or flying cars.<br />
							Just apps. Lots of mother flipping apps.</p>
						</header>
						<span class="image"><img src="images/pic01.jpg" alt="" /></span>
					</div>
					<a href="#one" class="goto-next scrolly">Next</a>
				</section>

			<!-- One -->
				<section id="one" class="spotlight style1 bottom">
					<span class="image fit main"><img src="images/pic02.jpg" alt="" /></span>
					<div class="content">
						<div class="container">
							<div class="row">
								<div class="col-4 col-12-medium">
									<header>
										<h2>Create and Use No-Code Modules</h2>
										<p>In 2022, skills shortages were ranked as the top 
										multi-cloud barrier.</p>
									</header>
								</div>
								<div class="col-4 col-12-medium">
									<p>No-code provisioning in Terraform Cloud lets users deploy 
									infrastructure resources without writing Terraform configuration. 
									This lets organizations adopt a self-service model by giving 
									developers with limited infrastructure knowledge a way to deploy 
									the resources they need.</p>
								</div>
								<div class="col-4 col-12-medium">
									<p>Modules can codify your infrastructure standards and architecture 
									requirements, making it easier for Terraform configuration authors 
									to deploy infrastructure that complies with best practices. No-code 
									provisioning lets users deploy infrastructure in modules without 
									writing any Terraform configuration, which makes your standards even 
									easier to comply with, and removes the dependency on infrastructure 
									teams or ticketing systems to give developers their required resources.</p>
								</div>
							</div>
						</div>
					</div>
					<a href="#two" class="goto-next scrolly">Next</a>
				</section>

			<!-- Two -->
				<section id="two" class="spotlight style2 right">
					<span class="image fit main"><img src="images/pic03.jpg" alt="" /></span>
					<div class="content">
						<header>
							<h2>Review module design recommendations</h2>
							<p>Unlike standard module deployment, users do not provision 
							infrastructure in no-code modules by referencing them in 
							written configuration. Because of this, you must write no-code 
							modules in a specific way.</p>
						</header>
						<p>No-code modules must follow standard module structure and define 
						all resources in the root repository of the directory. This lets 
						Terraform Cloud inspect the module, generate documentation, track 
						resource usage, and parse submodules and examples. It will display 
						this data in your Terraform Cloud registry.</p>
						<ul class="actions">
							<li><a href="#" class="button">Learn More</a></li>
						</ul>
					</div>
					<a href="#three" class="goto-next scrolly">Next</a>
				</section>

			<!-- Three -->
				<section id="three" class="spotlight style3 left">
					<span class="image fit main bottom"><img src="images/pic04.jpg" alt="" /></span>
					<div class="content">
						<header>
							<h2>Build For a Specific Use Case</h2>
							<p>No-code ready module users are typically less familiar with 
							Terraform and infrastructure management.</p>
						</header>
						<p>Reduce the amount of technical decision-making required to deploy 
						the module by scoping it to a single, specific use case. This 
						approach lets users focus on business concerns instead of infrastructure 
						concerns. For example, you could build modules that satisfy the following 
						well-scoped use cases, such as: Deploying all resources needed for a 
						three-tier web application OR Deploying a database with constraints on 
						resource allocation and deployment region</p>
						<ul class="actions">
							<li><a href="#" class="button">Learn More</a></li>
						</ul>
					</div>
					<a href="#four" class="goto-next scrolly">Next</a>
				</section>

			<!-- Footer -->
				<footer id="footer">
					<ul class="icons">
						<li><a href="#" class="icon brands alt fa-twitter"><span class="label">Twitter</span></a></li>
						<li><a href="#" class="icon brands alt fa-facebook-f"><span class="label">Facebook</span></a></li>
						<li><a href="#" class="icon brands alt fa-linkedin-in"><span class="label">LinkedIn</span></a></li>
						<li><a href="#" class="icon brands alt fa-instagram"><span class="label">Instagram</span></a></li>
						<li><a href="#" class="icon brands alt fa-github"><span class="label">GitHub</span></a></li>
						<li><a href="#" class="icon solid alt fa-envelope"><span class="label">Email</span></a></li>
					</ul>
					<ul class="copyright">
						<li>&copy; Untitled. All rights reserved.</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
					</ul>
				</footer>

		</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/jquery.dropotron.min.js"></script>
			<script src="assets/js/jquery.scrollex.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>
EOM

echo "Script complete."
