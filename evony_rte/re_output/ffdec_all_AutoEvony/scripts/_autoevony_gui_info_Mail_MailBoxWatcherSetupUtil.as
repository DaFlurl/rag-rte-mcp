package
{
   import autoevony.gui.info.Mail.MailBox;
   import flash.display.Sprite;
   import mx.binding.IWatcherSetupUtil;
   import mx.binding.PropertyWatcher;
   import mx.core.IFlexModuleFactory;
   
   public class _autoevony_gui_info_Mail_MailBoxWatcherSetupUtil extends Sprite implements IWatcherSetupUtil
   {
      
      public function _autoevony_gui_info_Mail_MailBoxWatcherSetupUtil()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         MailBox.watcherSetupUtil = new _autoevony_gui_info_Mail_MailBoxWatcherSetupUtil();
      }
      
      public function setup(param1:Object, param2:Function, param3:Array, param4:Array) : void
      {
         param4[0] = new PropertyWatcher("pageNo",{"propertyChange":true},[param3[0]],param2);
         param4[3] = new PropertyWatcher("mailsArray",{"propertyChange":true},[param3[2]],param2);
         param4[1] = new PropertyWatcher("totalPage",{"propertyChange":true},[param3[0]],param2);
         param4[2] = new PropertyWatcher("mailType",{"propertyChange":true},[param3[1]],param2);
         param4[0].updateParent(param1);
         param4[3].updateParent(param1);
         param4[1].updateParent(param1);
         param4[2].updateParent(param1);
      }
   }
}

