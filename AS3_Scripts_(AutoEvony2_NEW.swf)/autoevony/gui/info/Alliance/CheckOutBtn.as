// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.CheckOutBtn

package autoevony.gui.info.Alliance
{
    import mx.controls.Button;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.gui.MainScreen;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.common.constants.ColonyConstants;
    import flash.utils.getDefinitionByName;
    import mx.core.mx_internal;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class CheckOutBtn extends Button implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var armyTypeId:int;
        public var heroStasus:int;
        private var _1805312139styleType:String = "REwinBtn";

        private var _985752863player:String = MainScreen.getPlayer().playerInfo.userName;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};


        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CheckOutBtn._watcherSetupUtil = _arg_1;
        }


        private function set player(_arg_1:String):void
        {
            var _local_2:Object = this._985752863player;
            if (_local_2 !== _arg_1)
            {
                this._985752863player = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "player", _local_2, _arg_1));
            };
        }

        private function _CheckOutBtn_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():*
            {
                return (this.styleType);
            }, function (_arg_1:*):void
            {
                this.styleName = _arg_1;
            }, "this.styleName");
            result[0] = binding;
            return (result);
        }

        public function set colonyBtnEnable(_arg_1:int):void
        {
            if (_arg_1 != ColonyConstants.COLONY_STATUS_ABANDON)
            {
                this.enabled = true;
            }
            else
            {
                this.enabled = false;
            };
        }

        override public function initialize():void
        {
            var target:CheckOutBtn;
            var watcherSetupUtilClass:Object;
            var bindings:Array = this._CheckOutBtn_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_CheckOutBtnWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        private function get styleType():String
        {
            return (this._1805312139styleType);
        }

        public function set btnLable(_arg_1:String):void
        {
            this.label = _arg_1;
        }

        private function _CheckOutBtn_bindingExprs():void
        {
            var _local_1:*;
            this.styleName = this.styleType;
        }

        private function set styleType(_arg_1:String):void
        {
            var _local_2:Object = this._1805312139styleType;
            if (_local_2 !== _arg_1)
            {
                this._1805312139styleType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "styleType", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get player():String
        {
            return (this._985752863player);
        }

        public function set btnEnable(_arg_1:String):void
        {
            if (_arg_1 != this.player)
            {
                this.enabled = false;
            }
            else
            {
                this.enabled = true;
            };
        }


    }
}//package autoevony.gui.info.Alliance

