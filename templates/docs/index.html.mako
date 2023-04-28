<%!
    import pydmt.helpers.project
    import pydmt.helpers.urls
    import pydmt.helpers.signature
    import pydmt.helpers.misc
    import config.project
    import config.personal
%><!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>${pydmt.helpers.project.get_name()}</title>
		<!--suppress HtmlUnknownTarget -->
		<link rel="shortcut icon" href="favicon.ico"/>
		<meta name="Description" content="${config.project.description_short}"/>
		<meta name="Keywords" content="${config.personal.fullname}, ${config.personal.slug}, ${pydmt.helpers.project.get_name()}, ${', '.join(config.project.keywords)}"/>
	</head>
	<body>
		<h1>Welcome to the <i>${pydmt.helpers.project.get_name()}</i> web site</h1>
		
		<p>current version is ${pydmt.helpers.misc.get_version_str()}</p>

		<h2>A demo for the impatient is
			<a href="web/viewer.html?file=../riddling.pdf">here</a>
		</h2>
		<p>You can download the latest version of <b>${pydmt.helpers.project.get_name()}</b> from <!--suppress HtmlUnknownTarget -->
            <a href="riddling.pdf">here</a>.</p>

		<p>
			<b>${pydmt.helpers.project.get_name()}</b> is collection of riddles in tex format.
		</p>
		<p>Some related <b>${pydmt.helpers.project.get_name()}</b> project links:</p>
		<ul>
			<li>
			The <b>${pydmt.helpers.project.get_name()}</b> github project is <a title="${pydmt.helpers.project.get_name()} github project" href="${pydmt.helpers.urls.get_website_source()}">here</a>
			</li>
			<li>
			The <b>${pydmt.helpers.project.get_name()}</b> web site for the project is <a title="${pydmt.helpers.project.get_name()} web site" href="${pydmt.helpers.urls.get_website()}">here</a>
			</li>
			<li>
			The <b>${pydmt.helpers.project.get_name()}</b> git clone link is <a title="${pydmt.helpers.project.get_name()} git clone link" href="${pydmt.helpers.urls.get_website_git()}">here</a>
			</li>
		</ul>
		<p>
			Copyright ${config.personal.fullname} © ${pydmt.helpers.signature.get_copyright_years_long()}
			<a href="mailto:${config.personal.email}">${config.personal.email}</a>
		</p>
	</body>
</html>
