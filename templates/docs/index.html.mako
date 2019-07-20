<%!
    import config.project
    import config.git
    import config.personal
%><!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${config.project.project_name}</title>
		<!--suppress HtmlUnknownTarget -->
        <link rel="shortcut icon" href="favicon.ico"/>
		<meta name="Description" content="${config.project.project_long_description}"/>
		<meta name="Keywords" content="${config.personal.personal_fullname}, ${config.personal.personal_slug}, ${config.project.project_name}, ${', '.join(config.project.project_keywords)}"/>
		${config.project.project_google_analytics_snipplet}
	</head>
	<body>
		<h1>Welcome to the <i>${config.project.project_name}</i> web site</h1>
		
		<p>current version is ${config.git.git_last_tag}</p>

		<h2>A demo for the impatient is
			<a href="web/viewer.html?file=../riddling.pdf">here</a>
		</h2>
		<p>You can download the latest version of <b>${config.project.project_name}</b> from <!--suppress HtmlUnknownTarget -->
            <a href="riddling.pdf">here</a>.</p>

		<p>
			<b>${config.project.project_name}</b> is collection of riddles in tex format.
		</p>
		<p>Some related <b>${config.project.project_name}</b> project links:</p>
		<ul>
			<li>
			The <b>${config.project.project_name}</b> github project is <a title="${config.project.project_name} github project" href="${config.project.project_website_source}">here</a>
			</li>
			<li>
			The <b>${config.project.project_name}</b> web site for the project is <a title="${config.project.project_name} web site" href="${config.project.project_website}">here</a>
			</li>
			<li>
			The <b>${config.project.project_name}</b> git clone link is <a title="${config.project.project_name} git clone link" href="${config.project.project_website_git}">here</a>
			</li>
		</ul>
		<p>
			I would appreciate donations so that I could use my time to work on <b>${config.project.project_name}</b> more.
			If you do donate and would like me to work on some riddles or features then be sure to mention them
			in your donation remark on paypal.
		</p>
		${config.project.project_paypal_donate_button_snipplet}
		<p>
			Copyright ${config.personal.personal_fullname}, ${config.project.project_copyright_years}
			<a href="mailto:${config.personal.personal_email}">${config.personal.personal_email}</a>
		</p>
	</body>
</html>
