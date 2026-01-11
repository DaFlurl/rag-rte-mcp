// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.CastleBuildTip

package view.ui
{
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
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

    public class CastleBuildTip extends BaseTooltip implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1070217866nobility:String;
        private var len:int;
        public var _CastleBuildTip_Label1:Label;
        public var _CastleBuildTip_Text1:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "10";
                            this.bottom = "10";
                            this.right = "10";
                            this.top = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CastleBuildTip_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"contentheader1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_CastleBuildTip_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":315,
                                            "styleName":"ParamgraphText1"
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastleBuildTip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleBuildTip._watcherSetupUtil = _arg_1;
        }


        private function needNobility(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case 1:
                    this.nobility = Lang.msg("骑士");
                    return;
                case 2:
                    this.nobility = Lang.msg("准男爵");
                    return;
                case 3:
                    this.nobility = Lang.msg("男爵");
                    return;
                case 4:
                    this.nobility = Lang.msg("子爵");
                    return;
                case 5:
                    this.nobility = Lang.msg("伯爵");
                    return;
                case 6:
                    this.nobility = Lang.msg("侯爵");
                    return;
                case 7:
                    this.nobility = Lang.msg("公爵");
                    return;
                case 8:
                    this.nobility = Lang.msg("下级亲王");
                    return;
                case 9:
                    this.nobility = Lang.msg("上级亲王");
                    return;
            };
        }

        override public function initialize():void
        {
            var target:CastleBuildTip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleBuildTip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_CastleBuildTipWatcherSetupUtil");
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
        private function get nobility():String
        {
            return (this._1070217866nobility);
        }

        private function _CastleBuildTip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("建造城市");
            _local_1 = ((((Lang.msg("要新建一座城堡") + " ") + this.nobility) + ". ") + Lang.msg("250个民夫和各类资源各1W"));
        }

        public function set aryLength(_arg_1:int):void
        {
            this.len = _arg_1;
            this.needNobility(this.len);
        }

        private function set nobility(_arg_1:String):void
        {
            var _local_2:Object = this._1070217866nobility;
            if (_local_2 !== _arg_1)
            {
                this._1070217866nobility = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nobility", _local_2, _arg_1));
            };
        }

        private function _CastleBuildTip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("建造城市");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleBuildTip_Label1.text = _arg_1;
            }, "_CastleBuildTip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((((Lang.msg("要新建一座城堡") + " ") + this.nobility) + ". ") + Lang.msg("250个民夫和各类资源各1W"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleBuildTip_Text1.text = _arg_1;
            }, "_CastleBuildTip_Text1.text");
            result[1] = binding;
            return (result);
        }


    }
}//package view.ui

