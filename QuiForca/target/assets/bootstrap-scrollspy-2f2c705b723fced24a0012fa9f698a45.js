+function(e){"use strict";function t(n,r){this.$body=e(document.body);this.$scrollElement=e(n).is(document.body)?e(window):e(n);this.options=e.extend({},t.DEFAULTS,r);this.selector=(this.options.target||"")+" .nav li > a";this.offsets=[];this.targets=[];this.activeTarget=null;this.scrollHeight=0;this.$scrollElement.on("scroll.bs.scrollspy",e.proxy(this.process,this));this.refresh();this.process()}function n(n){return this.each(function(){var r=e(this);var i=r.data("bs.scrollspy");var s=typeof n=="object"&&n;if(!i)r.data("bs.scrollspy",i=new t(this,s));if(typeof n=="string")i[n]()})}t.VERSION="3.3.4";t.DEFAULTS={offset:10};t.prototype.getScrollHeight=function(){return this.$scrollElement[0].scrollHeight||Math.max(this.$body[0].scrollHeight,document.documentElement.scrollHeight)};t.prototype.refresh=function(){var t=this;var n="offset";var r=0;this.offsets=[];this.targets=[];this.scrollHeight=this.getScrollHeight();if(!e.isWindow(this.$scrollElement[0])){n="position";r=this.$scrollElement.scrollTop()}this.$body.find(this.selector).map(function(){var t=e(this);var i=t.data("target")||t.attr("href");var s=/^#./.test(i)&&e(i);return s&&s.length&&s.is(":visible")&&[[s[n]().top+r,i]]||null}).sort(function(e,t){return e[0]-t[0]}).each(function(){t.offsets.push(this[0]);t.targets.push(this[1])})};t.prototype.process=function(){var e=this.$scrollElement.scrollTop()+this.options.offset;var t=this.getScrollHeight();var n=this.options.offset+t-this.$scrollElement.height();var r=this.offsets;var i=this.targets;var s=this.activeTarget;var o;if(this.scrollHeight!=t){this.refresh()}if(e>=n){return s!=(o=i[i.length-1])&&this.activate(o)}if(s&&e<r[0]){this.activeTarget=null;return this.clear()}for(o=r.length;o--;){s!=i[o]&&e>=r[o]&&(r[o+1]===undefined||e<r[o+1])&&this.activate(i[o])}};t.prototype.activate=function(t){this.activeTarget=t;this.clear();var n=this.selector+'[data-target="'+t+'"],'+this.selector+'[href="'+t+'"]';var r=e(n).parents("li").addClass("active");if(r.parent(".dropdown-menu").length){r=r.closest("li.dropdown").addClass("active")}r.trigger("activate.bs.scrollspy")};t.prototype.clear=function(){e(this.selector).parentsUntil(this.options.target,".active").removeClass("active")};var r=e.fn.scrollspy;e.fn.scrollspy=n;e.fn.scrollspy.Constructor=t;e.fn.scrollspy.noConflict=function(){e.fn.scrollspy=r;return this};e(window).on("load.bs.scrollspy.data-api",function(){e('[data-spy="scroll"]').each(function(){var t=e(this);n.call(t,t.data())})})}(jQuery)