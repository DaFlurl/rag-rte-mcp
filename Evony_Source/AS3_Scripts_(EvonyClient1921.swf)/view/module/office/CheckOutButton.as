// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.CheckOutButton

package view.module.office
{
    import mx.controls.Button;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.Context;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.common.constants.ColonyConstants;
    import flash.utils.getDefinitionByName;
    import mx.core.mx_internal;
    import com.evony.Lang;
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

    use namespace mx_internal;

    public class CheckOutButton extends Button implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var heroStasus:int;
        public var armyTypeId:int;
        private var _1805312139styleType:String = "b75";

        private var _985752863player:String = Context.getInstance().getPlayerBean().playerInfo.userName;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CheckOutButton()
        {
            super();
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.fontSize = 12;
            };
            this.height = 25;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CheckOutButton._watcherSetupUtil = _arg_1;
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

        private function _CheckOutButton_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (styleType);
            }, function (_arg_1:Object):void
            {
                this.styleName = _arg_1;
            }, "this.styleName");
            result[0] = binding;
            return (result);
        }

        public function set colonyBtnEnable(_arg_1:int):void
        {
            if (_arg_1 == ColonyConstants.COLONY_STATUS_ABANDON)
            {
                this.enabled = false;
            }
            else
            {
                this.enabled = true;
            };
        }

        [Bindable(event="propertyChange")]
        private function get styleType():String
        {
            return (this._1805312139styleType);
        }

        override public function initialize():void
        {
            var target:CheckOutButton;
            var watcherSetupUtilClass:Object;
            var bindings:Array = _CheckOutButton_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_CheckOutButtonWatcherSetupUtil");
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

        public function set btnLable(_arg_1:String):void
        {
            this.label = Lang.msg(_arg_1);
        }

        private function _CheckOutButton_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = styleType;
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
            if (_arg_1 == player)
            {
                this.enabled = true;
            }
            else
            {
                this.enabled = false;
            };
        }


    }
}//package view.module.office

