(function(){!function(t,n){var r,e,o,u,l,a,i;return r=function(t,r,e){var o,u;return null==e&&(e={}),n.defaults(e,{includeRoot:!1}),this._patterns=this._patterns||{},o=this._patterns[t]||{},this._patterns[t]=o,u=r.match(/\:\w+/g)?r.match(/\:\w+/g).length:0,o[u]=r,this[t+"Path"]=function(){var t,r,l,c;return t=Array.prototype.slice.call(arguments),r=n(t[t.length-1]).isObject(),u=r?arguments.length-1:arguments.length,c=o[u],l=r?t.pop():null,e.includeRoot&&(c=i(c)),a(c,t,l)}},i=function(n){var r,e;return r=t.history,null==r||null==r.options||"/"===r.options.root?n:(e=r.options.root+"/"+n,e.replace("//","/"))},a=function(t,r,o){var u,l,a,i,c;for(a=t,"/"!==a.charAt(0)&&(a="/"+a),i=0,c=r.length;c>i;i++)l=r[i],a=a.replace(/\:\w+/,l);return u=e(o),u&&!n.isEmpty(u)&&(a+="?"+$.param(u)),a},e=function(t){var n,r,e;n={};for(r in t)e=t[r],o(t,r)&&"undefined"!=typeof value&&null!==value&&(n[r]=value);return n},u=Object.prototype.hasOwnProperty,o=function(t,n){return u.call(t,n)},l=t.Router.prototype.route,t.Router.prototype.route=function(t,n,e){return l.call(this,t,n,e),r.call(this,n,t)}}(Backbone,_)}).call(this);