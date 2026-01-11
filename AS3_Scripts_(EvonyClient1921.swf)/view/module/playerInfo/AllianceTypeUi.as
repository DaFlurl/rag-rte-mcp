// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.AllianceTypeUi

package view.module.playerInfo
{
    import mx.controls.Image;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.events.FlexEvent;
    import com.evony.factory.ImageManager;
    import com.evony.common.constants.AllianceConstants;
    import mx.events.PropertyChangeEvent;
    import mx.binding.utils.ChangeWatcher;
    import com.evony.Context;
    import mx.binding.utils.BindingUtils;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class AllianceTypeUi extends Image 
    {

        private var _2095520559playerInfo:PlayerInfoBean;
        private var watchers:Array = [];

        public function AllianceTypeUi()
        {
            this.addEventListener("creationComplete", ___AllianceTypeUi_Image1_creationComplete);
        }

        public function ___AllianceTypeUi_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set onLevelChange(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case AllianceConstants.TOP_POWER_FOR_ALLIANCE:
                    this.source = ImageManager.getAllianceLevelMap(AllianceConstants.TOP_POWER_FOR_ALLIANCE);
                    return;
                case AllianceConstants.TOP2_POWER_FOR_ALLIANCE:
                    this.source = ImageManager.getAllianceLevelMap(AllianceConstants.TOP2_POWER_FOR_ALLIANCE);
                    return;
                case AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE:
                    this.source = ImageManager.getAllianceLevelMap(AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE);
                    return;
                case AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE:
                    this.source = ImageManager.getAllianceLevelMap(AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE);
                    return;
                case AllianceConstants.LAST_POWER_FOR_ALLIANCE:
                    this.source = ImageManager.getAllianceLevelMap(AllianceConstants.LAST_POWER_FOR_ALLIANCE);
                    return;
                default:
                    this.source = null;
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        override public function initialize():void
        {
            super.initialize();
        }

        private function set playerInfo(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._2095520559playerInfo;
            if (_local_2 !== _arg_1)
            {
                this._2095520559playerInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            var _local_1:ChangeWatcher;
            this.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            for each (_local_1 in this.watchers)
            {
                _local_1.unwatch();
            };
            watchers[0] = BindingUtils.bindProperty(this, "onLevelChange", playerInfo, "levelId");
        }


    }
}//package view.module.playerInfo

