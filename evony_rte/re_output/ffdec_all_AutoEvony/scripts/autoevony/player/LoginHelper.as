package autoevony.player
{
   import com.adobe.crypto.SHA1;
   import com.evony.common.constants.CommonConstants;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   
   public class LoginHelper
   {
      
      private static var instance:LoginHelper = new LoginHelper();
      
      private static var fbPwObj:URLVariables = new URLVariables();
      
      public var proxyPort:String = "";
      
      public var proxyPw:String = "";
      
      public var skypeUn:String = "";
      
      public var password:String = "";
      
      public var proxyUn:String = "";
      
      public var serverIP:String = "";
      
      private var _isFBLoggedIn:Boolean = false;
      
      public var proxyHost:String = "";
      
      public var loginType:String = "";
      
      private var _isEvonyLoggedIn:Boolean = false;
      
      public var proxyType:String = "";
      
      public var theme:String = "";
      
      public var server:String = "";
      
      public var sid:String;
      
      public var username:String = "";
      
      public var autoScript:Boolean = false;
      
      public var autoRun:Boolean = false;
      
      public var secCode:String = "";
      
      public var autoLoginMinTime:String = "";
      
      public var autoLoginMaxTime:String = "";
      
      public var autoLogin:Boolean = false;
      
      public var tokenExpires:Number;
      
      public var strserverAlias:String = "";
      
      public var skypePw:String = "";
      
      public function LoginHelper(param1:Object = null)
      {
         var _loc2_:String = null;
         super();
         if(param1 == null)
         {
            return;
         }
         for each(_loc2_ in ["username","password","secCode","server","serverIP","proxyType","proxyPort","proxyHost","proxyUn","proxyPw","autoRun","autoScript","autoLogin","autoLoginMinTime","autoLoginMaxTime","loginType","skypeUn","skypePw","theme"])
         {
            if(param1.hasOwnProperty(_loc2_))
            {
               this[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public static function getUrlParam(param1:String, param2:String) : String
      {
         return param1.match(new RegExp(param2 + "=(.*?)[&|\"]"))[1];
      }
      
      public static function decryptUrl(param1:String) : String
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:int = 0;
         while(_loc5_ < param1.length / 2)
         {
            if(param1.charAt(2 * _loc5_) == "#" || param1.charAt(2 * _loc5_) == "&")
            {
               break;
            }
            if(param1.charAt(2 * _loc5_) >= "0" && param1.charAt(2 * _loc5_) <= "9")
            {
               _loc2_ = Number(param1.substr(2 * _loc5_,1));
            }
            else if(param1.charAt(2 * _loc5_) == "a" || param1.charAt(2 * _loc5_) == "A")
            {
               _loc2_ = 10;
            }
            else if(param1.charAt(2 * _loc5_) == "b" || param1.charAt(2 * _loc5_) == "B")
            {
               _loc2_ = 11;
            }
            else if(param1.charAt(2 * _loc5_) == "c" || param1.charAt(2 * _loc5_) == "C")
            {
               _loc2_ = 12;
            }
            else if(param1.charAt(2 * _loc5_) == "d" || param1.charAt(2 * _loc5_) == "D")
            {
               _loc2_ = 13;
            }
            else if(param1.charAt(2 * _loc5_) == "e" || param1.charAt(2 * _loc5_) == "E")
            {
               _loc2_ = 14;
            }
            else if(param1.charAt(2 * _loc5_) == "f" || param1.charAt(2 * _loc5_) == "F")
            {
               _loc2_ = 15;
            }
            if(param1.charAt(2 * _loc5_ + 1) >= "0" && param1.charAt(2 * _loc5_ + 1) <= "9")
            {
               _loc3_ = Number(param1.substr(2 * _loc5_ + 1,1));
            }
            else if(param1.charAt(2 * _loc5_ + 1) == "a" || param1.charAt(2 * _loc5_ + 1) == "A")
            {
               _loc3_ = 10;
            }
            else if(param1.charAt(2 * _loc5_ + 1) == "b" || param1.charAt(2 * _loc5_ + 1) == "B")
            {
               _loc3_ = 11;
            }
            else if(param1.charAt(2 * _loc5_ + 1) == "c" || param1.charAt(2 * _loc5_ + 1) == "C")
            {
               _loc3_ = 12;
            }
            else if(param1.charAt(2 * _loc5_ + 1) == "d" || param1.charAt(2 * _loc5_ + 1) == "D")
            {
               _loc3_ = 13;
            }
            else if(param1.charAt(2 * _loc5_ + 1) == "e" || param1.charAt(2 * _loc5_ + 1) == "E")
            {
               _loc3_ = 14;
            }
            else if(param1.charAt(2 * _loc5_ + 1) == "f" || param1.charAt(2 * _loc5_ + 1) == "F")
            {
               _loc3_ = 15;
            }
            _loc4_[_loc5_] = _loc2_ * 16 + _loc3_;
            _loc5_++;
         }
         var _loc6_:String = _loc4_.toString();
         trace(_loc6_);
         return _loc6_;
      }
      
      public static function getInstance() : LoginHelper
      {
         return instance;
      }
      
      public static function _ag364(param1:String) : String
      {
         param1 = param1.toLowerCase();
         return param1.substr(0,4) + SHA1.hash("052xa" + param1).substr(0,8);
      }
      
      public function getFbLoginObj() : Object
      {
         if(!this.isEvonyLoggedIn())
         {
            return null;
         }
         var _loc1_:Object = new Object();
         _loc1_[CommonConstants.LOGIN_PARAM_USER] = fbPwObj["fbuid"];
         _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] = "expires=" + fbPwObj["expires"];
         if(Boolean(fbPwObj["secret"]) && fbPwObj["secret"].length > 0)
         {
            _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] = _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] + "secret=" + fbPwObj["secret"];
         }
         _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] += "session_key=" + fbPwObj["session_key"];
         if(Boolean(fbPwObj["ss"]) && fbPwObj["ss"].length > 0)
         {
            _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] = _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] + "ss=" + fbPwObj["ss"];
         }
         if(Boolean(fbPwObj["user"]) && fbPwObj["user"].length > 0)
         {
            _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] = _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] + "user=" + fbPwObj["user"];
         }
         if(Boolean(fbPwObj["uid"]) && fbPwObj["uid"].length > 0)
         {
            _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] = _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] + "uid=" + fbPwObj["uid"];
         }
         if(Boolean(fbPwObj["base_domain"]) && fbPwObj["base_domain"].length > 0)
         {
            _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] = "base_domain=" + fbPwObj["base_domain"] + _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD];
         }
         if(Boolean(fbPwObj["access_token"]) && fbPwObj["access_token"].length > 0)
         {
            _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD] = "access_token=" + fbPwObj["access_token"] + _loc1_[CommonConstants.LOGIN_PARAM_PASSWORD];
         }
         _loc1_[CommonConstants.LOGIN_SSO_PARAM] = fbPwObj["fb_sig"];
         return _loc1_;
      }
      
      public function isEvonyLoggedIn() : Boolean
      {
         if(new Date().getTime() > this.tokenExpires)
         {
            this._isEvonyLoggedIn = false;
         }
         return this._isEvonyLoggedIn;
      }
      
      public function setIsEvonyLoggedIn(param1:Boolean) : void
      {
         this._isEvonyLoggedIn = param1;
      }
      
      public function isFBLoggedIn() : Boolean
      {
         return this._isFBLoggedIn;
      }
      
      public function setIsFBLoggedIn(param1:Boolean) : void
      {
         this._isFBLoggedIn = param1;
      }
      
      public function setFbPwObj(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc2_:Array = decryptUrl(param1).split("&");
         var _loc3_:Array = new Array();
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.indexOf("=") != -1)
            {
               _loc3_.push(_loc4_);
            }
         }
         fbPwObj = new URLVariables(_loc3_.join("&"));
      }
      
      public function isFbLoginType() : Boolean
      {
         return this.loginType == "fb";
      }
      
      public function getHashedEvonyPw() : String
      {
         return this.isFbLoginType() ? "DELETE" : SHA1.hash(this.password);
      }
   }
}

