// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.shop.Rules

package view.module.shop
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.TextArea;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import com.evony.Lang;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
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

    public class Rules extends Canvas implements IBindingClient 
    {

        public static var instancePopup:Rules;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _Rules_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":400,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Rules_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "24";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":TextArea,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                        this.right = "10";
                                        this.top = "5";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "selectable":false,
                                            "text":"\n1. Rewards for the top 10\nPlayers of top 10 who have spun more than 100 times can receive a Catapults Company; Players of top 10 who have spun 50 to 100 times can receive Catapults Squad.\n\n2. Extra rewards for the top 10\nThree players, ranked No.1, No.5, No.10, who have spun no less than 200 times will be granted a Legendary Gear Chest.\n\n3. Rewards for players who have spun more than 500 times\nPlayers who have spun more than 500 times will be granted Catapults Battalion; extra Battering Rams Battalion will be rewarded to No.1, No.5 and No.10 respectively.\n\n4. Special rewards for specific ranking\nPlayers ranking No.15, 20, 25, 30, 35, 40, 45 and 50 will receive Ballistae Squad. \n\n5. Other rewards\nPlayers ranking from 1st to 50th who are not qualified to claim the above aforementioned rewards, will receive 5 Amulets randomly, while 3 Amulets for those who are ranking from 51st to 100th.\n"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___Rules_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Rules()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 400;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Rules._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            if (instancePopup == null)
            {
                instancePopup = new (Rules)();
            };
            UIUtil.setPopopHelpWindowStye(instancePopup);
            if (!instancePopup.isPopUp)
            {
                PopUpManager.addPopUp(instancePopup, MainFrame.instance, true);
            };
            PopUpManager.centerPopUp(instancePopup);
        }


        private function _Rules_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("奖励规则");
        }

        public function ___Rules_Button1_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function _Rules_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("奖励规则");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Rules_Label1.text = _arg_1;
            }, "_Rules_Label1.text");
            result[0] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:Rules;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Rules_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_shop_RulesWatcherSetupUtil");
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

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }


    }
}//package view.module.shop

