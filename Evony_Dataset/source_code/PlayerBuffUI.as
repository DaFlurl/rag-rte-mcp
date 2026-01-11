// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.PlayerBuffUI

package view.castle
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import com.evony.common.beans.BuffBean;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.factory.ImageManager;
    import com.evony.Context;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.Event;
    import view.module.playerInfo.TruceChangeWin;
    import view.module.playerInfo.CancelSecurityCode;
    import view.AddEmail;
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

    public class PlayerBuffUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1185090783imgSrc:Object;
        public var _PlayerBuffUI_Image1:Image;
        private var bean:BuffBean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":26,
                    "height":26,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"_PlayerBuffUI_Image1",
                        "events":{
                            "click":"___PlayerBuffUI_Image1_click",
                            "complete":"___PlayerBuffUI_Image1_complete",
                            "updateComplete":"___PlayerBuffUI_Image1_updateComplete"
                        },
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":24,
                                "height":24,
                                "alpha":1
                            });
                        }
                    })]
                });
            }
        });
        private var defaultImg:Class = PlayerBuffUI_defaultImg;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PlayerBuffUI()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.borderStyle = "none";
                this.borderColor = 15378443;
                this.backgroundColor = 65793;
                this.backgroundAlpha = 0;
                this.cornerRadius = 2;
            };
            this.width = 26;
            this.height = 26;
            this.addEventListener("mouseOut", ___PlayerBuffUI_Canvas1_mouseOut);
            this.addEventListener("mouseOver", ___PlayerBuffUI_Canvas1_mouseOver);
            this.addEventListener("mouseMove", ___PlayerBuffUI_Canvas1_mouseMove);
            this.addEventListener("click", ___PlayerBuffUI_Canvas1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PlayerBuffUI._watcherSetupUtil = _arg_1;
        }


        public function set buffBean(_arg_1:Object):void
        {
            this.bean = (_arg_1 as BuffBean);
            switch (this.bean.typeId)
            {
                case PLayerBuffConstants.INCFOODPRODUCE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.INCFOODPRODUCE_BUFF);
                    return;
                case PLayerBuffConstants.INCIRONPRODUCE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.INCIRONPRODUCE_BUFF);
                    return;
                case PLayerBuffConstants.INCSTONEPRODUCE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.INCSTONEPRODUCE_BUFF);
                    return;
                case PLayerBuffConstants.INCWOODPRODUCE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.INCWOODPRODUCE_BUFF);
                    return;
                case PLayerBuffConstants.INCGOLDPRODUCE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.INCGOLDPRODUCE_BUFF);
                    return;
                case PLayerBuffConstants.PLAYERINCARMYATTACH_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.PLAYERINCARMYATTACH_BUFF);
                    return;
                case PLayerBuffConstants.PLAYERINCARMYDEFENCE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.PLAYERINCARMYDEFENCE_BUFF);
                    return;
                case PLayerBuffConstants.PLAYERPEACE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.PLAYERPEACE_BUFF);
                    return;
                case PLayerBuffConstants.PLAYERNOPEACE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.PLAYERNOPEACE_BUFF);
                    return;
                case PLayerBuffConstants.PLAYERPEACECOOLDOWN_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.PLAYERPEACECOOLDOWN_BUFF);
                    return;
                case PLayerBuffConstants.TROOPRELIVE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.TROOPRELIVE_BUFF);
                    return;
                case PLayerBuffConstants.KEEPSILENCE_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.KEEPSILENCE_BUFF);
                    return;
                case PLayerBuffConstants.PLAYER_NEW_BUFF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.PLAYER_NEW_BUFF);
                    return;
                case PLayerBuffConstants.RITUALOFPACTBUF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.RITUALOFPACTBUF);
                    return;
                case PLayerBuffConstants.RITUALOFPACTBUFX:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.RITUALOFPACTBUFX);
                    return;
                case PLayerBuffConstants.RITUALOFPACTBUFXX:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.RITUALOFPACTBUFXX);
                    return;
                case PLayerBuffConstants.RITUALOFPACTDELAYBUF:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.RITUALOFPACTDELAYBUF);
                    return;
                case PLayerBuffConstants.RITUALOFPACTDELAYBUFX:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.RITUALOFPACTDELAYBUFX);
                    return;
                case PLayerBuffConstants.RITUALOFPACTDELAYBUFXX:
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.RITUALOFPACTDELAYBUFXX);
                    return;
                case PLayerBuffConstants.PLAYEREMCARDBUF:
                    this.imgSrc = "images/icon/player/emcardbuff.png";
                    return;
                case "PlayerSpeakerBuf_BPAP_15":
                    this.imgSrc = "images/icon/player/jt_15.png";
                    Context.getInstance().iXcState = 1;
                    return;
                case "PlayerSpeakerBuf_BPAP":
                    this.imgSrc = "images/icon/player/jt_infinite.png";
                    Context.getInstance().iXcState = 2;
                    return;
                case "PlayerSpeakerBuf_SPAP_15":
                    this.imgSrc = "images/icon/player/by_15.png";
                    Context.getInstance().iXcState = 3;
                    return;
                case "PlayerSpeakerBuf_SPAP":
                    this.imgSrc = "images/icon/player/by_infinite.png";
                    Context.getInstance().iXcState = 4;
                    return;
                case "PlayerSpeakerBuf_GPAP_15":
                    this.imgSrc = "images/icon/player/hj_15.png";
                    Context.getInstance().iXcState = 5;
                    return;
                case "PlayerSpeakerBuf_GPAP":
                    this.imgSrc = "images/icon/player/hj_infinite.png";
                    Context.getInstance().iXcState = 6;
                    return;
                case "RitualOfPactBuf":
                    this.imgSrc = "images/items/RitualOfPactBuf.png";
                    return;
                case "RitualOfPactBufX":
                    this.imgSrc = "images/items/RitualOfPactBufX.png";
                    return;
                case "RitualOfPactBufXX":
                    this.imgSrc = "images/items/RitualOfPactBufXX.png";
                    return;
                case "RitualOfPactDelayBuf":
                    this.imgSrc = "images/items/RitualOfPactBuf.png";
                    return;
                case "RitualOfPactBufX":
                    this.imgSrc = "images/items/RitualOfPactBufX.png";
                    return;
                case "RitualOfPactBufXX":
                    this.imgSrc = "images/items/RitualOfPactBufXX.png";
                    return;
                case "DreamTruceBuff":
                    this.imgSrc = "images/icon/gold24.jpg";
                    return;
                case "HelpIncreaseProductionBuff":
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.INCFOODPRODUCE_BUFF);
                    return;
                case "CompanionsBuff":
                    this.imgSrc = "images/icon/CompanionsBuff.png";
                    return;
                case "StaminaBuff":
                    this.imgSrc = "images/icon/StaminaBuff.png";
                    return;
                case "FriendsProtectionBuff":
                    this.imgSrc = "images/icon/FriendsProtectionBuff.png";
                    return;
                case "ReduceTroopsUpkeepBuff":
                    this.imgSrc = "images/icon/cooker.png";
                    return;
                case "doubleBuilding":
                    this.imgSrc = "images/icon/doubleBuilding.png";
                    return;
                case "DeclearWarCooldownBuff":
                    this.imgSrc = "images/icon/DeclearWarCooldownBuff.png";
                    return;
                case "TopeVotesPrivilegeBuf":
                    this.imgSrc = "images/icon/topvotes.png";
                    return;
                case "TopVotesUseKeepSilenceBuff":
                    this.imgSrc = "images/icon/silence.png";
                    return;
                case "TopVotesUseKeepNoGetTaxBuff":
                    this.imgSrc = "images/icon/restrain.png";
                    return;
                case "TopVoteUserChangeSupportBuff":
                    this.imgSrc = "images/icon/honor.png";
                    return;
                case "TopVoteUseGiveGoleCountBuff":
                    this.imgSrc = "images/icon/favor.png";
                    return;
                case "KeepNoGetTaxBuf":
                    this.imgSrc = "images/icon/restrain.png";
                    return;
                case "KeepSilenceXBuff":
                    this.imgSrc = this.defaultImg;
                    return;
                case "RemovingSecurityCodeBuff":
                    this.imgSrc = "images/icon/Copper24.jpg";
                    Context.getInstance().bCancelSecurityCode = true;
                    return;
                case "HungerBuff":
                    this.imgSrc = "images/icon/hungry.png";
                    return;
                case "StopTroopsUpkeepBuff":
                    this.imgSrc = "images/icon/shop/StopTroopsUpkeep.png";
                    return;
                case "ReduceTroopsUpkeepBuff2":
                    this.imgSrc = "images/icon/shop/talismanofthesated2015_bu2.png";
                    return;
                case "ReduceArmyActionBuff":
                    this.imgSrc = "images/icon/shop/fleetfeet.png";
                    return;
                case "ArmyStaminaBuff":
                    this.imgSrc = "images/icon/shop/enduranceoftheimmortas.png";
                    return;
                case "IncAllHeroPropertyBuff":
                    this.imgSrc = "images/icon/shop/alchemistsamplifier.png";
                    return;
                case "KillAllPeopleBuff":
                    this.imgSrc = "images/icon/shop/opportunistsplague.png";
                    return;
                case "IncArmyActionTimeBuff":
                    this.imgSrc = "images/icon/shop/lostinthewastes.png";
                    return;
                case "ReduceallheropropertyBuff":
                    this.imgSrc = "images/icon/shop/poisonedfeast.png";
                    return;
                case "ForceopenclosegateBuff":
                    this.imgSrc = "images/icon/shop/brokengates.png";
                    return;
                case "ForceopenclosegateCooldownBuff":
                    this.imgSrc = "images/icon/shop/brokengates.png";
                    return;
                case "HauntedCastleBuf":
                    this.imgSrc = "images/icon/shop/HalloweenCastle_S.png";
                    return;
                case "HauntedCastleAdvBuf":
                    this.imgSrc = "images/icon/shop/HalloweenCastle_S.png";
                    return;
                case "ChocolateBunnyBuff":
                    this.imgSrc = "images/icon/shop/chocolate.png";
                    return;
                case "UpriseBonusBuff":
                    this.imgSrc = "images/icon/shop/UpriseBonusBuff.png";
                    return;
                case "ChocolateBunnyBuff2":
                    this.imgSrc = "images/icon/shop/ChocolateBunnyBuff2.png";
                    return;
                case "ServerStopTroopsUpkeep":
                    this.imgSrc = "images/icon/shop/ServerStopTroopsUpkeep.png";
                    return;
                case "PlayerPeaceUniteServerBuff":
                    this.imgSrc = ImageManager.getBufferMap(PLayerBuffConstants.PLAYERPEACE_BUFF);
                    return;
                case "EasterPVPBuff":
                    this.imgSrc = "images/icon/shop/pvpbuf.png";
                    return;
                default:
                    this.imgSrc = "images/icon/DeclearWarCooldownBuff2.png";
            };
        }

        private function set imgSrc(_arg_1:Object):void
        {
            var _local_2:Object = this._1185090783imgSrc;
            if (_local_2 !== _arg_1)
            {
                this._1185090783imgSrc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgSrc", _local_2, _arg_1));
            };
        }

        public function ___PlayerBuffUI_Canvas1_click(_arg_1:MouseEvent):void
        {
            clickHandle();
        }

        public function ___PlayerBuffUI_Image1_updateComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        override public function initialize():void
        {
            var target:PlayerBuffUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PlayerBuffUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_PlayerBuffUIWatcherSetupUtil");
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

        public function ___PlayerBuffUI_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function ___PlayerBuffUI_Canvas1_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function ___PlayerBuffUI_Canvas1_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        public function ___PlayerBuffUI_Image1_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        private function clickHandle():void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            if (this.bean.typeId == "DreamTruceBuff")
            {
                TruceChangeWin.show();
            }
            else
            {
                if (this.bean.typeId == "RemovingSecurityCodeBuff")
                {
                    CancelSecurityCode.show(0);
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get imgSrc():Object
        {
            return (this._1185090783imgSrc);
        }

        public function ___PlayerBuffUI_Canvas1_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function onClick():void
        {
            if (this.bean.typeId == PLayerBuffConstants.PLAYEREMCARDBUF)
            {
                AddEmail.show();
            };
        }

        private function onMouseOut():void
        {
            PlayerBuffTooltip.hide();
        }

        private function _PlayerBuffUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.imgSrc;
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            PlayerBuffTooltip.mouseMove(_arg_1);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            PlayerBuffTooltip.show(this.bean, _arg_1);
        }

        private function _PlayerBuffUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.imgSrc);
            }, function (_arg_1:Object):void
            {
                _PlayerBuffUI_Image1.source = _arg_1;
            }, "_PlayerBuffUI_Image1.source");
            result[0] = binding;
            return (result);
        }


    }
}//package view.castle

