  


<!DOCTYPE html>
<html>
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# githubog: http://ogp.me/ns/fb/githubog#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>OpenTuringCompiler/test/test13.t at master · Open-Turing-Project/OpenTuringCompiler</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="apple-touch-icon-114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="apple-touch-icon-114.png" />
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="apple-touch-icon-144.png" />
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="apple-touch-icon-144.png" />
    <link rel="logo" type="image/svg" href="http://github-media-downloads.s3.amazonaws.com/github-logo.svg" />
    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">

    
    
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />

    <meta content="authenticity_token" name="csrf-param" />
<meta content="tB6K86Xh08uetWkevsI+4NJWEV/zda8N7dUws70WlUc=" name="csrf-token" />

    <link href="https://a248.e.akamai.net/assets.github.com/assets/github-407693f9f73c33bc72d72bf9656fbf5ae05597d3.css" media="screen" rel="stylesheet" type="text/css" />
    <link href="https://a248.e.akamai.net/assets.github.com/assets/github2-5243c715429b6e8c71b6c5fd2591dc96cc921061.css" media="screen" rel="stylesheet" type="text/css" />
    


        <script src="https://a248.e.akamai.net/assets.github.com/assets/frameworks-d61440caec5d2210a2242b084cdb2bc6597e00b7.js" type="text/javascript"></script>
      <script src="https://a248.e.akamai.net/assets.github.com/assets/github-089ad85d7bd16439d94518cf478e48592191e07d.js" type="text/javascript"></script>
      

        <link rel='permalink' href='/Open-Turing-Project/OpenTuringCompiler/blob/d7535986a914f3cc45fc8153891fc3a312358c37/test/test13.t'>
    <meta property="og:title" content="OpenTuringCompiler"/>
    <meta property="og:type" content="githubog:gitrepository"/>
    <meta property="og:url" content="https://github.com/Open-Turing-Project/OpenTuringCompiler"/>
    <meta property="og:image" content="https://secure.gravatar.com/avatar/f7c25a6a79d139ff46b987a68336e84e?s=420&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"/>
    <meta property="og:site_name" content="GitHub"/>
    <meta property="og:description" content="A cross platform Turing Compiler built with LLVM. Contribute to OpenTuringCompiler development by creating an account on GitHub."/>
    <meta property="twitter:card" content="summary"/>
    <meta property="twitter:site" content="@GitHub">
    <meta property="twitter:title" content="Open-Turing-Project/OpenTuringCompiler"/>

    <meta name="description" content="A cross platform Turing Compiler built with LLVM. Contribute to OpenTuringCompiler development by creating an account on GitHub." />

  <link href="https://github.com/Open-Turing-Project/OpenTuringCompiler/commits/master.atom" rel="alternate" title="Recent Commits to OpenTuringCompiler:master" type="application/atom+xml" />

  </head>


  <body class="logged_in page-blob windows vis-public env-production  ">
    <div id="wrapper">

      

      

      


        <div class="header header-logged-in true">
          <div class="container clearfix">

            <a class="header-logo-blacktocat" href="https://github.com/">
  <span class="mega-icon mega-icon-blacktocat"></span>
</a>

            <div class="divider-vertical"></div>

              <a href="/notifications" class="notification-indicator tooltipped downwards" title="You have no unread notifications">
    <span class="mail-status all-read"></span>
  </a>
  <div class="divider-vertical"></div>


              <div class="topsearch command-bar-activated ">
  <form accept-charset="UTF-8" action="/search" class="command_bar_form" id="top_search_form" method="get">
  <a href="/search/advanced" class="advanced-search-icon tooltipped downwards command-bar-search" id="advanced_search" title="Advanced search"><span class="mini-icon mini-icon-advanced-search "></span></a>

  <input type="text" name="q" id="command-bar" placeholder="Search or type a command" tabindex="1" data-username="mirhagk" autocapitalize="off">

  <span class="mini-icon help tooltipped downwards" title="Show command bar help">
    <span class="mini-icon mini-icon-help"></span>
  </span>

  <input type="hidden" name="ref" value="commandbar">

  <div class="divider-vertical"></div>
</form>
  <ul class="top-nav">
      <li class="explore"><a href="https://github.com/explore">Explore</a></li>
      <li><a href="https://gist.github.com">Gist</a></li>
      <li><a href="/blog">Blog</a></li>
    <li><a href="http://help.github.com">Help</a></li>
  </ul>
</div>


            

  
    <ul id="user-links">
      <li>
        <a href="https://github.com/mirhagk" class="name">
          <img height="20" src="https://secure.gravatar.com/avatar/378a3ad4bed0e6a5d9fd71be8d2cad8c?s=140&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png" width="20" /> mirhagk
        </a>
      </li>
      <li>
        <a href="/new" id="new_repo" class="tooltipped downwards" title="Create a new repo">
          <span class="mini-icon mini-icon-create"></span>
        </a>
      </li>
      <li>
        <a href="/settings/profile" id="account_settings"
          class="tooltipped downwards"
          title="Account settings (You have no verified emails)">
          <span class="mini-icon mini-icon-account-settings"></span>
            <span class="setting_warning">!</span>
        </a>
      </li>
      <li>
          <a href="/logout" data-method="post" id="logout" class="tooltipped downwards" title="Sign out">
            <span class="mini-icon mini-icon-logout"></span>
          </a>
      </li>
    </ul>



            
          </div>
        </div>


      <div class="global-notice warn"><div class="global-notice-inner"><h2>You don't have any verified emails.  We recommend <a href="https://github.com/settings/emails">verifying</a> at least one email.</h2><p>Email verification will help our support team help you in case you have any email issues or lose your password.</p></div></div>

      


            <div class="site hfeed" itemscope itemtype="http://schema.org/WebPage">
      <div class="hentry">
        
        <div class="pagehead repohead instapaper_ignore readability-menu">
          <div class="container">
            <div class="title-actions-bar">
              


<ul class="pagehead-actions">


    <li class="subscription">
      <form accept-charset="UTF-8" action="/notifications/subscribe" data-autosubmit="true" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="tB6K86Xh08uetWkevsI+4NJWEV/zda8N7dUws70WlUc=" /></div>  <input id="repository_id" name="repository_id" type="hidden" value="3473978" />

    <div class="select-menu js-menu-container js-select-menu">
      <span class="minibutton select-menu-button js-menu-target">
        <span class="js-select-button">
          <span class="mini-icon mini-icon-watching"></span>
          Watch
        </span>
      </span>

      <div class="select-menu-modal-holder js-menu-content">
        <div class="select-menu-modal">
          <div class="select-menu-header">
            <span class="select-menu-title">Notification status</span>
            <span class="mini-icon mini-icon-remove-close js-menu-close"></span>
          </div> <!-- /.select-menu-header -->

          <div class="select-menu-list js-navigation-container js-select-menu-pane">

            <div class="select-menu-item js-navigation-item js-navigation-target selected">
              <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
              <div class="select-menu-item-text">
                <input checked="checked" id="do_included" name="do" type="radio" value="included" />
                <h4>Not watching</h4>
                <span class="description">You only receive notifications for discussions in which you participate or are @mentioned.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="mini-icon mini-icon-watching"></span>
                  Watch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item js-navigation-target ">
              <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
              <div class="select-menu-item-text">
                <input id="do_subscribed" name="do" type="radio" value="subscribed" />
                <h4>Watching</h4>
                <span class="description">You receive notifications for all discussions in this repository.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="mini-icon mini-icon-unwatch"></span>
                  Unwatch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item js-navigation-target ">
              <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
              <div class="select-menu-item-text">
                <input id="do_ignore" name="do" type="radio" value="ignore" />
                <h4>Ignoring</h4>
                <span class="description">You do not receive any notifications for discussions in this repository.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="mini-icon mini-icon-mute"></span>
                  Stop ignoring
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

          </div> <!-- /.select-menu-list -->

        </div> <!-- /.select-menu-modal -->
      </div> <!-- /.select-menu-modal-holder -->
    </div> <!-- /.select-menu -->

</form>
    </li>

    <li class="js-toggler-container js-social-container starring-container ">
      <a href="/Open-Turing-Project/OpenTuringCompiler/unstar" class="minibutton js-toggler-target star-button starred" data-remote="true" data-method="post" rel="nofollow"><span class="mini-icon mini-icon-remove-star"></span>
      </a><a href="/Open-Turing-Project/OpenTuringCompiler/star" class="minibutton js-toggler-target star-button unstarred" data-remote="true" data-method="post" rel="nofollow">
        <span class="mini-icon mini-icon-star"></span></a><a class="social-count js-social-count" href="/Open-Turing-Project/OpenTuringCompiler/stargazers">2</a>
    </li>

        <li><a href="/Open-Turing-Project/OpenTuringCompiler/fork" class="minibutton js-toggler-target fork-button lighter" rel="nofollow" data-method="post"><span class="mini-icon mini-icon-branch-create"></span></a><a href="/Open-Turing-Project/OpenTuringCompiler/network" class="social-count">1</a>
        </li>


</ul>

              <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
                <span class="repo-label"><span>public</span></span>
                <span class="mega-icon mega-icon-public-repo"></span>
                <span class="author vcard">
                  <a href="/Open-Turing-Project" class="url fn" itemprop="url" rel="author">
                  <span itemprop="title">Open-Turing-Project</span>
                  </a></span> /
                <strong><a href="/Open-Turing-Project/OpenTuringCompiler" class="js-current-repository">OpenTuringCompiler</a></strong>
              </h1>
            </div>

            

  <ul class="tabs">
    <li><a href="/Open-Turing-Project/OpenTuringCompiler" class="selected" highlight="repo_sourcerepo_downloadsrepo_commitsrepo_tagsrepo_branches">Code</a></li>
    <li><a href="/Open-Turing-Project/OpenTuringCompiler/network" highlight="repo_network">Network</a></li>
    <li><a href="/Open-Turing-Project/OpenTuringCompiler/pulls" highlight="repo_pulls">Pull Requests <span class='counter'>0</span></a></li>

      <li><a href="/Open-Turing-Project/OpenTuringCompiler/issues" highlight="repo_issues">Issues <span class='counter'>19</span></a></li>

      <li><a href="/Open-Turing-Project/OpenTuringCompiler/wiki" highlight="repo_wiki">Wiki</a></li>


    <li><a href="/Open-Turing-Project/OpenTuringCompiler/graphs" highlight="repo_graphsrepo_contributors">Graphs</a></li>


  </ul>
  
<div class="tabnav">

  <span class="tabnav-right">
    <ul class="tabnav-tabs">
          <li><a href="/Open-Turing-Project/OpenTuringCompiler/tags" class="tabnav-tab" highlight="repo_tags">Tags <span class="counter blank">0</span></a></li>
    </ul>
    
  </span>

  <div class="tabnav-widget scope">


    <div class="select-menu js-menu-container js-select-menu js-branch-menu">
      <a class="minibutton select-menu-button js-menu-target" data-hotkey="w" data-ref="master">
        <span class="mini-icon mini-icon-branch"></span>
        <i>branch:</i>
        <span class="js-select-button">master</span>
      </a>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container js-select-menu-pane">

        <div class="select-menu-modal js-select-menu-pane">
          <div class="select-menu-header">
            <span class="select-menu-title">Switch branches/tags</span>
            <span class="mini-icon mini-icon-remove-close js-menu-close"></span>
          </div> <!-- /.select-menu-header -->

          <div class="select-menu-filters">
            <div class="select-menu-text-filter">
              <input type="text" id="commitish-filter-field" class="js-select-menu-text-filter js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
            </div> <!-- /.select-menu-text-filter -->
            <div class="select-menu-tabs">
              <ul>
                <li class="select-menu-tab">
                  <a href="#" data-filter="branches" class="js-select-menu-tab selected">Branches</a>
                </li>
                <li class="select-menu-tab">
                  <a href="#" data-filter="tags" class="js-select-menu-tab">Tags</a>
                </li>
              </ul>
            </div><!-- /.select-menu-tabs -->
          </div><!-- /.select-menu-filters -->

          <div class="select-menu-list js-filter-tab js-filter-branches css-truncate" data-filterable-for="commitish-filter-field" data-filterable-type="substring">



              <div class="select-menu-item js-navigation-item js-navigation-target selected">
                <span class="select-menu-checkmark mini-icon mini-icon-confirm"></span>
                <a href="/Open-Turing-Project/OpenTuringCompiler/blob/master/test/test13.t" class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target" data-name="master" rel="nofollow" title="master">master</a>
              </div> <!-- /.select-menu-item -->

              <div class="select-menu-no-results js-not-filterable">Nothing to show</div>
          </div> <!-- /.select-menu-list -->


          <div class="select-menu-list js-filter-tab js-filter-tags css-truncate" data-filterable-for="commitish-filter-field" data-filterable-type="substring" style="display:none;">


            <div class="select-menu-no-results js-not-filterable">Nothing to show</div>

          </div> <!-- /.select-menu-list -->

        </div> <!-- /.select-menu-modal -->
      </div> <!-- /.select-menu-modal-holder -->
    </div> <!-- /.select-menu -->

  </div> <!-- /.scope -->

  <ul class="tabnav-tabs">
    <li><a href="/Open-Turing-Project/OpenTuringCompiler" class="selected tabnav-tab" highlight="repo_source">Files</a></li>
    <li><a href="/Open-Turing-Project/OpenTuringCompiler/commits/master" class="tabnav-tab" highlight="repo_commits">Commits</a></li>
    <li><a href="/Open-Turing-Project/OpenTuringCompiler/branches" class="tabnav-tab" highlight="repo_branches" rel="nofollow">Branches <span class="counter ">1</span></a></li>
  </ul>

</div>

  
  
  


            
          </div>
        </div><!-- /.repohead -->

        <div id="js-repo-pjax-container" class="container context-loader-container" data-pjax-container>
          


<!-- blob contrib key: blob_contributors:v21:1a254fa006e2686301cec434d71662e9 -->
<!-- blob contrib frag key: views10/v8/blob_contributors:v21:1a254fa006e2686301cec434d71662e9 -->


<div id="slider">
    <div class="frame-meta">

      <p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

        <div class="breadcrumb">
          <span class='bold'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/Open-Turing-Project/OpenTuringCompiler" class="js-slide-to" data-direction="back" itemscope="url"><span itemprop="title">OpenTuringCompiler</span></a></span></span> / <span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/Open-Turing-Project/OpenTuringCompiler/tree/master/test" class="js-slide-to" data-direction="back" itemscope="url"><span itemprop="title">test</span></a></span> / <strong class="final-path">test13.t</strong> <span class="js-zeroclipboard zeroclipboard-button" data-clipboard-text="test/test13.t" data-copied-hint="copied!" title="copy to clipboard"><span class="mini-icon mini-icon-clipboard"></span></span>
        </div>

      <a href="/Open-Turing-Project/OpenTuringCompiler/find/master" class="js-slide-to" data-hotkey="t" style="display:none">Show File Finder</a>


        <div class="commit commit-loader file-history-tease js-deferred-content" data-url="/Open-Turing-Project/OpenTuringCompiler/contributors/master/test/test13.t">
          Fetching contributors…

          <div class="participation">
            <p class="loader-loading"><img alt="Octocat-spinner-32-eaf2f5" height="16" src="https://a248.e.akamai.net/assets.github.com/images/spinners/octocat-spinner-32-EAF2F5.gif?1340659511" width="16" /></p>
            <p class="loader-error">Cannot retrieve contributors at this time</p>
          </div>
        </div>

    </div><!-- ./.frame-meta -->

    <div class="frames">
      <div class="frame" data-permalink-url="/Open-Turing-Project/OpenTuringCompiler/blob/d7535986a914f3cc45fc8153891fc3a312358c37/test/test13.t" data-title="OpenTuringCompiler/test/test13.t at master · Open-Turing-Project/OpenTuringCompiler · GitHub" data-type="blob">

        <div id="files" class="bubble">
          <div class="file">
            <div class="meta">
              <div class="info">
                <span class="icon"><b class="mini-icon mini-icon-text-file"></b></span>
                <span class="mode" title="File Mode">file</span>
                  <span>146 lines (118 sloc)</span>
                <span>3.355 kb</span>
              </div>
              <div class="actions">
                <div class="button-group">
                        <a class="minibutton tooltipped leftwards"
                           title="Clicking this button will automatically fork this project so you can edit the file"
                           href="/Open-Turing-Project/OpenTuringCompiler/edit/master/test/test13.t"
                           data-method="post" rel="nofollow">Edit</a>
                  <a href="/Open-Turing-Project/OpenTuringCompiler/raw/master/test/test13.t" class="button minibutton " id="raw-url">Raw</a>
                    <a href="/Open-Turing-Project/OpenTuringCompiler/blame/master/test/test13.t" class="button minibutton ">Blame</a>
                  <a href="/Open-Turing-Project/OpenTuringCompiler/commits/master/test/test13.t" class="button minibutton " rel="nofollow">History</a>
                </div><!-- /.button-group -->
              </div><!-- /.actions -->

            </div>
                <div class="data type-turing js-blob-data">
      <table cellpadding="0" cellspacing="0" class="lines">
        <tr>
          <td>
            <pre class="line_numbers"><span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>
<span id="L60" rel="#L60">60</span>
<span id="L61" rel="#L61">61</span>
<span id="L62" rel="#L62">62</span>
<span id="L63" rel="#L63">63</span>
<span id="L64" rel="#L64">64</span>
<span id="L65" rel="#L65">65</span>
<span id="L66" rel="#L66">66</span>
<span id="L67" rel="#L67">67</span>
<span id="L68" rel="#L68">68</span>
<span id="L69" rel="#L69">69</span>
<span id="L70" rel="#L70">70</span>
<span id="L71" rel="#L71">71</span>
<span id="L72" rel="#L72">72</span>
<span id="L73" rel="#L73">73</span>
<span id="L74" rel="#L74">74</span>
<span id="L75" rel="#L75">75</span>
<span id="L76" rel="#L76">76</span>
<span id="L77" rel="#L77">77</span>
<span id="L78" rel="#L78">78</span>
<span id="L79" rel="#L79">79</span>
<span id="L80" rel="#L80">80</span>
<span id="L81" rel="#L81">81</span>
<span id="L82" rel="#L82">82</span>
<span id="L83" rel="#L83">83</span>
<span id="L84" rel="#L84">84</span>
<span id="L85" rel="#L85">85</span>
<span id="L86" rel="#L86">86</span>
<span id="L87" rel="#L87">87</span>
<span id="L88" rel="#L88">88</span>
<span id="L89" rel="#L89">89</span>
<span id="L90" rel="#L90">90</span>
<span id="L91" rel="#L91">91</span>
<span id="L92" rel="#L92">92</span>
<span id="L93" rel="#L93">93</span>
<span id="L94" rel="#L94">94</span>
<span id="L95" rel="#L95">95</span>
<span id="L96" rel="#L96">96</span>
<span id="L97" rel="#L97">97</span>
<span id="L98" rel="#L98">98</span>
<span id="L99" rel="#L99">99</span>
<span id="L100" rel="#L100">100</span>
<span id="L101" rel="#L101">101</span>
<span id="L102" rel="#L102">102</span>
<span id="L103" rel="#L103">103</span>
<span id="L104" rel="#L104">104</span>
<span id="L105" rel="#L105">105</span>
<span id="L106" rel="#L106">106</span>
<span id="L107" rel="#L107">107</span>
<span id="L108" rel="#L108">108</span>
<span id="L109" rel="#L109">109</span>
<span id="L110" rel="#L110">110</span>
<span id="L111" rel="#L111">111</span>
<span id="L112" rel="#L112">112</span>
<span id="L113" rel="#L113">113</span>
<span id="L114" rel="#L114">114</span>
<span id="L115" rel="#L115">115</span>
<span id="L116" rel="#L116">116</span>
<span id="L117" rel="#L117">117</span>
<span id="L118" rel="#L118">118</span>
<span id="L119" rel="#L119">119</span>
<span id="L120" rel="#L120">120</span>
<span id="L121" rel="#L121">121</span>
<span id="L122" rel="#L122">122</span>
<span id="L123" rel="#L123">123</span>
<span id="L124" rel="#L124">124</span>
<span id="L125" rel="#L125">125</span>
<span id="L126" rel="#L126">126</span>
<span id="L127" rel="#L127">127</span>
<span id="L128" rel="#L128">128</span>
<span id="L129" rel="#L129">129</span>
<span id="L130" rel="#L130">130</span>
<span id="L131" rel="#L131">131</span>
<span id="L132" rel="#L132">132</span>
<span id="L133" rel="#L133">133</span>
<span id="L134" rel="#L134">134</span>
<span id="L135" rel="#L135">135</span>
<span id="L136" rel="#L136">136</span>
<span id="L137" rel="#L137">137</span>
<span id="L138" rel="#L138">138</span>
<span id="L139" rel="#L139">139</span>
<span id="L140" rel="#L140">140</span>
<span id="L141" rel="#L141">141</span>
<span id="L142" rel="#L142">142</span>
<span id="L143" rel="#L143">143</span>
<span id="L144" rel="#L144">144</span>
<span id="L145" rel="#L145">145</span>
<span id="L146" rel="#L146">146</span>
</pre>
          </td>
          <td width="100%">
                  <div class="highlight"><pre><div class='line' id='LC1'>% The 13 printing test</div><div class='line' id='LC2'>% As I develop the compiler I use the new features</div><div class='line' id='LC3'>% to print 13 in increasingly complex ways...</div><div class='line' id='LC4'><br/></div><div class='line' id='LC5'>% test constants</div><div class='line' id='LC6'>const threeConst := 3</div><div class='line' id='LC7'>% test parsing weird constants</div><div class='line' id='LC8'>const testConst := -6.90460016972063023e-05</div><div class='line' id='LC9'>const oneConst : real := 1</div><div class='line' id='LC10'><br/></div><div class='line' id='LC11'>% test type declarations, records and multi-dimensional arrays</div><div class='line' id='LC12'>type recType :  record</div><div class='line' id='LC13'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mat : array 1..threeConst, 1..boolean of boolean</div><div class='line' id='LC14'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hovering : real</div><div class='line' id='LC15'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;end record</div><div class='line' id='LC16'><br/></div><div class='line' id='LC17'>var rec,otherRec : recType</div><div class='line' id='LC18'><br/></div><div class='line' id='LC19'>% test alternate multi-dimensional array index syntax</div><div class='line' id='LC20'>rec.mat(1,2) := true</div><div class='line' id='LC21'><br/></div><div class='line' id='LC22'>% test string length and &#39;var&#39; parameters</div><div class='line' id='LC23'>var bob : int</div><div class='line' id='LC24'>proc SetBob(var bob : int)</div><div class='line' id='LC25'>&nbsp;&nbsp;&nbsp;&nbsp;%get bob</div><div class='line' id='LC26'>&nbsp;&nbsp;&nbsp;&nbsp;bob := length(&quot;123456&quot;)</div><div class='line' id='LC27'>end SetBob</div><div class='line' id='LC28'>SetBob(bob)</div><div class='line' id='LC29'><br/></div><div class='line' id='LC30'>% test case statements and string concatenation</div><div class='line' id='LC31'>var prinString := &quot;P&quot;</div><div class='line' id='LC32'>proc TestCaseStat(bob : int)</div><div class='line' id='LC33'>&nbsp;&nbsp;&nbsp;&nbsp;case bob of</div><div class='line' id='LC34'>&nbsp;&nbsp;&nbsp;&nbsp;label 7,9:</div><div class='line' id='LC35'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;prinString += &quot;I&quot;</div><div class='line' id='LC36'>&nbsp;&nbsp;&nbsp;&nbsp;label 5:</div><div class='line' id='LC37'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;prinString += &quot;R&quot;</div><div class='line' id='LC38'>&nbsp;&nbsp;&nbsp;&nbsp;label:</div><div class='line' id='LC39'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;prinString += &quot;N&quot;</div><div class='line' id='LC40'>&nbsp;&nbsp;&nbsp;&nbsp;end case</div><div class='line' id='LC41'>end TestCaseStat</div><div class='line' id='LC42'>TestCaseStat(5)</div><div class='line' id='LC43'>TestCaseStat(9)</div><div class='line' id='LC44'>TestCaseStat(839)</div><div class='line' id='LC45'><br/></div><div class='line' id='LC46'>% test complex type returns</div><div class='line' id='LC47'>fcn RetPrintingStr () : string</div><div class='line' id='LC48'>&nbsp;&nbsp;&nbsp;&nbsp;result prinString + &quot;TING &quot;</div><div class='line' id='LC49'>end RetPrintingStr</div><div class='line' id='LC50'><br/></div><div class='line' id='LC51'>var assignStr : string</div><div class='line' id='LC52'>assignStr := RetPrintingStr()</div><div class='line' id='LC53'><br/></div><div class='line' id='LC54'>%test no parenthesis procedures</div><div class='line' id='LC55'>procedure SetHovering</div><div class='line' id='LC56'>&nbsp;&nbsp;&nbsp;&nbsp;rec.hovering := 0.1 * threeConst / threeConst + 0.9 * oneConst</div><div class='line' id='LC57'>end SetHovering</div><div class='line' id='LC58'>SetHovering</div><div class='line' id='LC59'><br/></div><div class='line' id='LC60'>% test modules</div><div class='line' id='LC61'>module Print13</div><div class='line' id='LC62'><br/></div><div class='line' id='LC63'>&nbsp;&nbsp;&nbsp;&nbsp;%test equality checking and code inside a module</div><div class='line' id='LC64'>&nbsp;&nbsp;&nbsp;&nbsp;if bob = 6 and ~(-9 &gt; 7) &amp; &quot;bob&quot; = &quot;bob&quot; and &quot;lol&quot; ~= &quot;hi&quot; and rec.hovering = 1 and rec.mat(1)(2) then</div><div class='line' id='LC65'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%test no newline</div><div class='line' id='LC66'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;put assignStr ..</div><div class='line' id='LC67'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%test multi-expr</div><div class='line' id='LC68'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;put 13,&quot;...\n&quot; ..</div><div class='line' id='LC69'>&nbsp;&nbsp;&nbsp;&nbsp;end if</div><div class='line' id='LC70'>&nbsp;&nbsp;&nbsp;&nbsp;</div><div class='line' id='LC71'>&nbsp;&nbsp;&nbsp;&nbsp;% test module variables</div><div class='line' id='LC72'>&nbsp;&nbsp;&nbsp;&nbsp;var lolArr,lolArr2 : flexible array 1..0 of int</div><div class='line' id='LC73'><br/></div><div class='line' id='LC74'>&nbsp;&nbsp;&nbsp;&nbsp;fcn CalcStuff(num1 : int, num2 : int) : int</div><div class='line' id='LC75'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;result num1 - num2**2</div><div class='line' id='LC76'>&nbsp;&nbsp;&nbsp;&nbsp;end CalcStuff</div><div class='line' id='LC77'><br/></div><div class='line' id='LC78'>&nbsp;&nbsp;&nbsp;&nbsp;proc PutStuff(num : int)</div><div class='line' id='LC79'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var bob : int := 2**num</div><div class='line' id='LC80'><br/></div><div class='line' id='LC81'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bob := CalcStuff(bob,2)</div><div class='line' id='LC82'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bob div= 2</div><div class='line' id='LC83'><br/></div><div class='line' id='LC84'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if bob &gt; 14 then</div><div class='line' id='LC85'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return</div><div class='line' id='LC86'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;end if</div><div class='line' id='LC87'><br/></div><div class='line' id='LC88'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;var ed := bob - 1    </div><div class='line' id='LC89'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;put ed</div><div class='line' id='LC90'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return</div><div class='line' id='LC91'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;put 9</div><div class='line' id='LC92'>&nbsp;&nbsp;&nbsp;&nbsp;end PutStuff</div><div class='line' id='LC93'>end Print13</div><div class='line' id='LC94'><br/></div><div class='line' id='LC95'>fcn Second( arr : array 1..* of int ) : int</div><div class='line' id='LC96'>&nbsp;&nbsp;&nbsp;&nbsp;result arr(2)</div><div class='line' id='LC97'>end Second</div><div class='line' id='LC98'><br/></div><div class='line' id='LC99'>% test weird lower bounds</div><div class='line' id='LC100'>var inittedArr : array 4..7 of int := init(5,6,13,9)</div><div class='line' id='LC101'>for i : 1..inittedArr(6)</div><div class='line' id='LC102'>&nbsp;&nbsp;&nbsp;&nbsp;new Print13.lolArr, upper(Print13.lolArr) + 1</div><div class='line' id='LC103'>&nbsp;&nbsp;&nbsp;&nbsp;Print13.lolArr(i) := i</div><div class='line' id='LC104'>end for</div><div class='line' id='LC105'>if upper(Print13.lolArr) ~= 13 or lower(inittedArr) ~= 4 then</div><div class='line' id='LC106'>&nbsp;&nbsp;&nbsp;&nbsp;put &quot;FAILED flexible arrays or array initialization&quot;</div><div class='line' id='LC107'>end if</div><div class='line' id='LC108'>% lolArr = 1,2,3,4...</div><div class='line' id='LC109'><br/></div><div class='line' id='LC110'><br/></div><div class='line' id='LC111'>loop</div><div class='line' id='LC112'>&nbsp;&nbsp;&nbsp;&nbsp;Print13.lolArr(2) += 1</div><div class='line' id='LC113'>&nbsp;&nbsp;&nbsp;&nbsp;exit when Print13.lolArr(2) &gt;= 4</div><div class='line' id='LC114'>end loop</div><div class='line' id='LC115'><br/></div><div class='line' id='LC116'><br/></div><div class='line' id='LC117'>% test implicit copy of arrays</div><div class='line' id='LC118'>new Print13.lolArr2, upper(Print13.lolArr)</div><div class='line' id='LC119'>Print13.lolArr2 := Print13.lolArr</div><div class='line' id='LC120'><br/></div><div class='line' id='LC121'>% set bob to 5</div><div class='line' id='LC122'>bob := Print13.lolArr2(9) - Second(Print13.lolArr2)</div><div class='line' id='LC123'><br/></div><div class='line' id='LC124'>% test implicit copy of records</div><div class='line' id='LC125'>otherRec := rec</div><div class='line' id='LC126'><br/></div><div class='line' id='LC127'>% test passing and returning records</div><div class='line' id='LC128'>fcn RetAndPassRec(passRec : recType) : recType</div><div class='line' id='LC129'>&nbsp;&nbsp;&nbsp;&nbsp;result passRec</div><div class='line' id='LC130'>end RetAndPassRec</div><div class='line' id='LC131'>rec := RetAndPassRec(otherRec)</div><div class='line' id='LC132'><br/></div><div class='line' id='LC133'>%check record copy and test comparison</div><div class='line' id='LC134'>if rec ~= otherRec then</div><div class='line' id='LC135'>&nbsp;&nbsp;&nbsp;&nbsp;put rec.hovering, &quot; is not equal to &quot;, otherRec.hovering, &quot; after copy.&quot;</div><div class='line' id='LC136'>end if</div><div class='line' id='LC137'><br/></div><div class='line' id='LC138'>if bob &lt;= 5 or bob &gt; 7 then</div><div class='line' id='LC139'>&nbsp;&nbsp;&nbsp;&nbsp;var ed := 6</div><div class='line' id='LC140'>&nbsp;&nbsp;&nbsp;&nbsp;Print13.PutStuff (ed) % this one returns early and never prints</div><div class='line' id='LC141'>&nbsp;&nbsp;&nbsp;&nbsp;Print13.PutStuff (bob)</div><div class='line' id='LC142'>elsif 5 &gt;= 5 and 6 div 2 &lt; 3 then</div><div class='line' id='LC143'>&nbsp;&nbsp;&nbsp;&nbsp;put 6</div><div class='line' id='LC144'>else</div><div class='line' id='LC145'>&nbsp;&nbsp;&nbsp;&nbsp;put 5 &gt;= 4</div><div class='line' id='LC146'>end if</div></pre></div>
          </td>
        </tr>
      </table>
  </div>

          </div>
        </div>

        <a href="#jump-to-line" rel="facebox" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
        <div id="jump-to-line" style="display:none">
          <h2>Jump to Line</h2>
          <form accept-charset="UTF-8" class="js-jump-to-line-form">
            <input class="textfield js-jump-to-line-field" type="text">
            <div class="full-button">
              <button type="submit" class="button">Go</button>
            </div>
          </form>
        </div>

      </div>
    </div>
</div>

<div id="js-frame-loading-template" class="frame frame-loading large-loading-area" style="display:none;">
  <img class="js-frame-loading-spinner" src="https://a248.e.akamai.net/assets.github.com/images/spinners/octocat-spinner-128.gif?1347543527" height="64" width="64">
</div>


        </div>
      </div>
      <div class="context-overlay"></div>
    </div>

      <div id="footer-push"></div><!-- hack for sticky footer -->
    </div><!-- end of wrapper - hack for sticky footer -->

      <!-- footer -->
      <div id="footer">
  <div class="container clearfix">

      <dl class="footer_nav">
        <dt>GitHub</dt>
        <dd><a href="https://github.com/about">About us</a></dd>
        <dd><a href="https://github.com/blog">Blog</a></dd>
        <dd><a href="https://github.com/contact">Contact &amp; support</a></dd>
        <dd><a href="http://enterprise.github.com/">GitHub Enterprise</a></dd>
        <dd><a href="http://status.github.com/">Site status</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>Applications</dt>
        <dd><a href="http://mac.github.com/">GitHub for Mac</a></dd>
        <dd><a href="http://windows.github.com/">GitHub for Windows</a></dd>
        <dd><a href="http://eclipse.github.com/">GitHub for Eclipse</a></dd>
        <dd><a href="http://mobile.github.com/">GitHub mobile apps</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>Services</dt>
        <dd><a href="http://get.gaug.es/">Gauges: Web analytics</a></dd>
        <dd><a href="http://speakerdeck.com">Speaker Deck: Presentations</a></dd>
        <dd><a href="https://gist.github.com">Gist: Code snippets</a></dd>
        <dd><a href="http://jobs.github.com/">Job board</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>Documentation</dt>
        <dd><a href="http://help.github.com/">GitHub Help</a></dd>
        <dd><a href="http://developer.github.com/">Developer API</a></dd>
        <dd><a href="http://github.github.com/github-flavored-markdown/">GitHub Flavored Markdown</a></dd>
        <dd><a href="http://pages.github.com/">GitHub Pages</a></dd>
      </dl>

      <dl class="footer_nav">
        <dt>More</dt>
        <dd><a href="http://training.github.com/">Training</a></dd>
        <dd><a href="https://github.com/edu">Students &amp; teachers</a></dd>
        <dd><a href="http://shop.github.com">The Shop</a></dd>
        <dd><a href="/plans">Plans &amp; pricing</a></dd>
        <dd><a href="http://octodex.github.com/">The Octodex</a></dd>
      </dl>

      <hr class="footer-divider">


    <p class="right">&copy; 2013 <span title="0.13042s from fe16.rs.github.com">GitHub</span> Inc. All rights reserved.</p>
    <a class="left" href="https://github.com/">
      <span class="mega-icon mega-icon-invertocat"></span>
    </a>
    <ul id="legal">
        <li><a href="https://github.com/site/terms">Terms of Service</a></li>
        <li><a href="https://github.com/site/privacy">Privacy</a></li>
        <li><a href="https://github.com/security">Security</a></li>
    </ul>

  </div><!-- /.container -->

</div><!-- /.#footer -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
          <div class="suggester-container">
              <div class="suggester fullscreen-suggester js-navigation-container" id="fullscreen_suggester"
                 data-url="/Open-Turing-Project/OpenTuringCompiler/suggestions/commit/d7535986a914f3cc45fc8153891fc3a312358c37">
              </div>
          </div>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped leftwards" title="Exit Zen Mode">
      <span class="mega-icon mega-icon-normalscreen"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped leftwards"
      title="Switch themes">
      <span class="mini-icon mini-icon-brightness"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="mini-icon mini-icon-exclamation"></span>
      Something went wrong with that request. Please try again.
      <a href="#" class="mini-icon mini-icon-remove-close ajax-error-dismiss"></a>
    </div>

    
    
    <span id='server_response_time' data-time='0.13111' data-host='fe16'></span>
    
  </body>
</html>

