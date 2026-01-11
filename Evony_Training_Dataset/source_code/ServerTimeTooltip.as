// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.ServerTimeTooltip

package view.ui
{
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import com.evony.GameConfig;
    import com.evony.Lang;
    import com.evony.Context;
    import com.evony.util.UIUtil;
    import flash.utils.getDefinitionByName;
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

    public class ServerTimeTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ServerTimeTooltip_Label1:Label;
        public var _ServerTimeTooltip_Label2:Label;
        public var _ServerTimeTooltip_Label4:Label;
        public var _ServerTimeTooltip_Label5:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "center";
                            this.left = "6";
                            this.right = "6";
                            this.top = "6";
                            this.bottom = "6";
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"tooltip",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ServerTimeTooltip_Label1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyValue1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ServerTimeTooltip_Label2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"English",
                                                        "styleName":"PropertyValue1"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ServerTimeTooltip_Label4",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ServerTimeTooltip_Label5",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyValue1"});
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ServerTimeTooltip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ServerTimeTooltip._watcherSetupUtil = _arg_1;
        }


        private function _ServerTimeTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((GameConfig.instance.strserverAlias + "(") + GameConfig.instance.serverID) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ServerTimeTooltip_Label1.text = _arg_1;
            }, "_ServerTimeTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("服务器语言:");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ServerTimeTooltip_Label2.text = _arg_1;
            }, "_ServerTimeTooltip_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("服务器时间:");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ServerTimeTooltip_Label4.text = _arg_1;
            }, "_ServerTimeTooltip_Label4.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((((((((Context.getInstance().serverYear + "-") + Context.getInstance().serverMonth) + "-") + Context.getInstance().serverDate) + " ") + UIUtil.FormatTwoString(Context.getInstance().serverHours)) + ":") + UIUtil.FormatTwoString(Context.getInstance().serverMinutes));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ServerTimeTooltip_Label5.text = _arg_1;
            }, "_ServerTimeTooltip_Label5.text");
            result[3] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:ServerTimeTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ServerTimeTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_ServerTimeTooltipWatcherSetupUtil");
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

        private function _ServerTimeTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (((GameConfig.instance.strserverAlias + "(") + GameConfig.instance.serverID) + ")");
            _local_1 = Lang.msg("服务器语言:");
            _local_1 = Lang.msg("服务器时间:");
            _local_1 = ((((((((Context.getInstance().serverYear + "-") + Context.getInstance().serverMonth) + "-") + Context.getInstance().serverDate) + " ") + UIUtil.FormatTwoString(Context.getInstance().serverHours)) + ":") + UIUtil.FormatTwoString(Context.getInstance().serverMinutes));
        }


    }
}//package view.ui

