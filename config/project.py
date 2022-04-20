import datetime
import config.general

project_github_username = "veltzer"
project_name = "riddles-book"
project_website = f"https://{project_github_username}.github.io/{project_name}"
project_website_source = f"https://github.com/{project_github_username}/{project_name}"
project_website_git = f"git://github.com/{project_github_username}/{project_name}.git"
project_paypal_donate_button_id = "ASPRXR59H2NTQ"
project_google_analytics_tracking_id = "UA-80195674-1"
project_long_description = "A riddle collection done with open source tools"
# keywords to put on html pages or for search, dont put the name of the project or my details
# as they will be added automatically...
project_keywords = [
    "riddles",
    "riddling",
    "collection",
]
project_license = "GPLV3"
project_year_started = "2011"
project_description = f"""The idea is to create a collection of many riddles for your enjoyment.

Tools include: make, pdflatex, lacheck, latex, dvips, ps2pdf, latex2html, perl, sketch, git,
        flexpaper, pdf2swf, qpdf, pdfinfo, pdftex, pdftohtml, luatex, xetex and possibly more.

If you want to see the result checkout:
{project_website}

If you want to compile this package then:
* install all required packages.
        Ubuntu users you are in luck: just run "scripts/ubuntu_install.sh"...
* make
All the output is in the "out" folder.
"""

deb_package = False

project_copyright_years = ", ".join(
    map(str, range(int(project_year_started), datetime.datetime.now().year + 1)))
if str(config.general.general_current_year) == project_year_started:
    project_copyright_years = config.general.general_current_year
else:
    project_copyright_years = f"{project_year_started} - {config.general.general_current_year}"

project_google_analytics_tracking_id = "0"
project_google_analytics_snipplet = f"""<script type="text/javascript">
(function(i,s,o,g,r,a,m){{i["GoogleAnalyticsObject"]=r;i[r]=i[r]||function(){{
(i[r].q=i[r].q||[]).push(arguments)}},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
}})(window,document,"script","https://www.google-analytics.com/analytics.js","ga");

ga("create", "{project_google_analytics_tracking_id}", "auto");
ga("send", "pageview");

</script>"""

project_paypal_donate_button_id = "0"
project_paypal_donate_button_snipplet = f"""<form action="https://www.paypal.com/cgi-bin/webscr"
    method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="{project_paypal_donate_button_id}">
<input type="image" src="https://www.paypalobjects.com/en_US/IL/i/btn/btn_donateCC_LG.gif" name="submit"
alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>"""
