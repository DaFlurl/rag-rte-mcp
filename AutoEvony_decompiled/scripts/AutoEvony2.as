package
{
   import autoevony.common.Utils;
   import autoevony.event.OnLoggedOutEvent;
   import autoevony.event.OnLoginEvent;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.LoginScreen;
   import autoevony.gui.MainScreen;
   import autoevony.gui.controls.popup.PopUpWinManager;
   import autoevony.net.Connection;
   import autoevony.player.LoginHelper;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.server.events.LoginResponse;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.core.Application;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class AutoEvony2 extends Application
   {
      
      private static var domainsAllowed:Boolean = allowDomains();
      
      mx_internal static var _AutoEvony2_StylesInit_done:Boolean = false;
      
      private var _embed__font_DejaVu_Sans_bold_italic_653331763:Class;
      
      private var m_serverIp:String = "";
      
      private var _embed__font_DejaVu_Sans_bold_normal_1092898251:Class;
      
      private var _embed__font_DejaVu_Sans_medium_normal_356255468:Class;
      
      private var m_queueJobs:MainScreen = null;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var m_winMan:PopUpWinManager = null;
      
      private var m_loginForm:LoginScreen = null;
      
      private var _embed__font_DejaVu_Sans_medium_italic_83311012:Class;
      
      public function AutoEvony2()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({"type":Application});
         this._embed__font_DejaVu_Sans_bold_italic_653331763 = AutoEvony2__embed__font_DejaVu_Sans_bold_italic_653331763;
         this._embed__font_DejaVu_Sans_bold_normal_1092898251 = AutoEvony2__embed__font_DejaVu_Sans_bold_normal_1092898251;
         this._embed__font_DejaVu_Sans_medium_italic_83311012 = AutoEvony2__embed__font_DejaVu_Sans_medium_italic_83311012;
         this._embed__font_DejaVu_Sans_medium_normal_356255468 = AutoEvony2__embed__font_DejaVu_Sans_medium_normal_356255468;
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.backgroundColor = 6513767;
            this.backgroundGradientAlphas = [0,0];
            this.paddingLeft = 0;
            this.paddingTop = 0;
            this.paddingRight = 0;
            this.paddingBottom = 0;
            this.horizontalGap = 0;
            this.verticalGap = 0;
            this.modalTransparency = 0.3;
            this.modalTransparencyBlur = 1;
            this.modalTransparencyColor = 2105893;
            this.modalTransparencyDuration = 100;
         };
         mx_internal::_AutoEvony2_StylesInit();
         this.minWidth = 710;
         this.minHeight = 550;
         this.layout = "absolute";
         this.addEventListener("creationComplete",this.___AutoEvony2_Application1_creationComplete);
      }
      
      private static function allowDomains() : Boolean
      {
         if(Security.sandboxType != "application")
         {
            Security.allowDomain("*");
         }
         return true;
      }
      
      public function onLogin(param1:LoginResponse) : void
      {
         var _loc2_:SharedObject = null;
         if(param1.ok != 1)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE,this.onLogin);
            _loc2_ = SharedObject.getLocal("config");
            _loc2_.data.now = LoginHelper.getInstance();
            _loc2_.flush();
         }
      }
      
      public function ___AutoEvony2_Application1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function init() : void
      {
         ActionFactory.getInstance().setSender(Connection.getInstance());
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE,this.onLogin);
         this.addEventListener(OnLoginEvent.ON_LOGIN_EVENT,this.onServerLoginEvent);
         this.addEventListener(OnLoggedOutEvent.ON_LOGOUT_EVENT,this.onServerLogoutEvent);
         if(this.m_winMan == null)
         {
            this.m_winMan = new PopUpWinManager(this);
         }
         this.addEventListener(popUpWinShowEvent.POP_UP_WIN_SHOW,this.newPopUpWin);
         dispatchEvent(new OnLoggedOutEvent());
      }
      
      public function onJobQueue() : void
      {
         this.setupConfig();
         this.m_queueJobs = new MainScreen();
         this.removeAllChildren();
         this.addChild(this.m_queueJobs);
         this.m_loginForm = null;
      }
      
      private function onServerLogoutEvent(param1:OnLoggedOutEvent = null) : void
      {
         this.m_loginForm = new LoginScreen();
         this.m_loginForm.percentWidth = 100;
         this.m_loginForm.percentHeight = 100;
         this.removeAllChildren();
         this.addChild(this.m_loginForm);
         this.m_queueJobs = null;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onServerLoginEvent(param1:OnLoginEvent = null) : void
      {
         if(param1.loginType == OnLoginEvent.LOGIN_TYPE_FB)
         {
            if(Version.isTraceOn())
            {
               trace("**********  attempt fb connect code  ***********");
            }
         }
         else if(param1.loginType == OnLoginEvent.LOGIN_TYPE_EV)
         {
            if(Version.isTraceOn())
            {
               trace("**********  attempt default connect code  ***********");
            }
         }
         else
         {
            if(Version.isTraceOn())
            {
               trace("**********  unrcognized login type, attempt default connect code  ***********");
            }
            param1.loginType = 0;
         }
         this.connect(param1.loginType);
      }
      
      private function setupConfig() : void
      {
         var _loc1_:LoginHelper = LoginHelper.getInstance();
         _loc1_.loginType = this.m_loginForm._loginTypeSelect.selectedItem.data;
         _loc1_.username = this.m_loginForm.username.text;
         _loc1_.password = this.m_loginForm.password.text;
         _loc1_.secCode = this.m_loginForm.secCode.text;
         _loc1_.server = this.m_loginForm.serverNumT.text;
         _loc1_.serverIP = this.m_serverIp;
         _loc1_.autoRun = this.m_loginForm.autoRun.selected;
         _loc1_.autoScript = this.m_loginForm.autoScript.selected;
         _loc1_.autoLogin = this.m_loginForm.autoLogin.selected;
         _loc1_.autoLoginMinTime = this.m_loginForm.autoLoginMinTime.text;
         _loc1_.autoLoginMaxTime = this.m_loginForm.autoLoginMaxTime.text;
         _loc1_.proxyType = this.m_loginForm._proxySelect.selectedItem.data;
         _loc1_.proxyPort = this.m_loginForm._proxyPortInput.text;
         _loc1_.proxyHost = this.m_loginForm._proxyHostInput.text;
         _loc1_.proxyUn = this.m_loginForm._proxyUnInput.text;
         _loc1_.proxyPw = this.m_loginForm._proxyPwInput.text;
         _loc1_.skypeUn = this.m_loginForm._skypeUnInput.text;
         _loc1_.skypePw = this.m_loginForm._skypePwInput.text;
         _loc1_.theme = this.m_loginForm._themeSelect.selectedItem.toString();
      }
      
      public function resetStage() : void
      {
         if(this.m_loginForm != null && this.getChildIndex(this.m_loginForm) != -1)
         {
            this.removeAllChildren();
            this.addChild(this.m_loginForm);
         }
         else if(this.m_queueJobs != null && this.getChildIndex(this.m_queueJobs) != -1)
         {
            this.removeAllChildren();
            this.addChild(this.m_queueJobs);
         }
      }
      
      private function newPopUpWin(param1:popUpWinShowEvent = null) : void
      {
         this.m_winMan.newPopUpWin(param1);
      }
      
      private function connect(param1:int, param2:int = 0) : void
      {
         var hlink:HTTPService;
         var enteredServerId:String = null;
         var tarAddr:String = null;
         var loginType:int = param1;
         var attemptCount:int = param2;
         enteredServerId = this.m_loginForm.serverNumT.text.toUpperCase();
         this.m_loginForm.notice.text = "Looking up ip address for server " + enteredServerId;
         tarAddr = "http://" + enteredServerId.toLowerCase() + ".evony.com/config.xml";
         hlink = new HTTPService();
         hlink.url = tarAddr;
         hlink.method = "GET";
         hlink.resultFormat = HTTPService.RESULT_FORMAT_XML;
         hlink.contentType = HTTPService.CONTENT_TYPE_XML;
         hlink.addEventListener(ResultEvent.RESULT,function(param1:ResultEvent):void
         {
            var _loc2_:XML = new XML(param1.message.body.toString());
            var _loc3_:String = _loc2_.serverID;
            var _loc4_:String = _loc2_.SID;
            m_serverIp = _loc2_.server;
            if(_loc3_ == "")
            {
               m_loginForm.notice.text = "Error fetching config file for " + enteredServerId;
               m_loginForm.button.enabled = true;
               m_loginForm.autoRun.enabled = true;
            }
            else if(enteredServerId != _loc3_.toUpperCase())
            {
               m_loginForm.notice.text = "Abnormal config file for " + enteredServerId + ", showing wrong server " + _loc3_;
               m_loginForm.button.enabled = true;
               m_loginForm.autoRun.enabled = true;
            }
            else if(m_serverIp == "")
            {
               m_loginForm.notice.text = "Could not find ip address of server " + enteredServerId + " from config file";
               m_loginForm.button.enabled = true;
               m_loginForm.autoRun.enabled = true;
            }
            else
            {
               m_loginForm.notice.text = "Found server " + _loc3_ + " at: " + m_serverIp + ". Attempting to connect...";
               if(_loc2_.serverAlias)
               {
                  LoginHelper.getInstance().strserverAlias = _loc2_.serverAlias;
               }
               LoginHelper.getInstance().server = _loc3_;
               LoginHelper.getInstance().sid = _loc4_;
               onJobQueue();
            }
         });
         hlink.addEventListener(FaultEvent.FAULT,function(param1:FaultEvent):void
         {
            var _loc2_:int = 0;
            if(attemptCount >= 10)
            {
               if(m_loginForm.autoLogin.selected)
               {
                  _loc2_ = Utils.getRandomInt(40,120);
                  m_loginForm.notice.text = "Error: Unable to read " + tarAddr + ". Next attemp in " + _loc2_ + "s...";
                  Utils.callLater(_loc2_ * 1000,connect,[0]);
               }
               else
               {
                  dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error: Unable to read " + tarAddr + " after " + attemptCount + " attemps. Aborting login process."));
                  m_loginForm.button.enabled = true;
                  m_loginForm.autoRun.enabled = true;
               }
            }
            else
            {
               _loc2_ = Utils.getRandomInt(3,9);
               m_loginForm.notice.text = "Error: Unable to read " + tarAddr + ". Next attemp in " + _loc2_ + "s...";
               Utils.callLater(_loc2_ * 1000,connect,[++attemptCount]);
            }
         });
         hlink.send();
      }
      
      mx_internal function _AutoEvony2_StylesInit() : void
      {
         var _loc1_:CSSStyleDeclaration = null;
         var _loc2_:Array = null;
         if(mx_internal::_AutoEvony2_StylesInit_done)
         {
            return;
         }
         mx_internal::_AutoEvony2_StylesInit_done = true;
         StyleManager.mx_internal::initProtoChainRoots();
      }
   }
}

