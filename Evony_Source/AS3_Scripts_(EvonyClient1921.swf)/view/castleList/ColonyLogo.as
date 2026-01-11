// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.ColonyLogo

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import com.evony.common.beans.ColonyBean;
    import com.evony.common.beans.CastleBean;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import flash.filters.GlowFilter;
    import com.evony.common.constants.ColonyConstants;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import flash.utils.getDefinitionByName;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
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

    public class ColonyLogo extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1494871014myPhoto:Image;
        private var _pageN:int;
        private var _1197684682colonyBean:ColonyBean;
        private var _colonyNum:int;
        private var _113836232castleBean:CastleBean;
        private var _parent:AllCastleFrame;
        public var _ColonyLogo_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":60,
                    "height":33,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"myPhoto",
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":36,
                                "width":60
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_ColonyLogo_Label1",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"castleLogo"});
                        }
                    })]
                });
            }
        });
        private var _colonyArr:ArrayCollection = new ArrayCollection();
        private var castleTooltip:SuzerainInfoTooltip = SuzerainInfoTooltip.getInstance();
        private var suzInfowin:SuzerainInfoWin = SuzerainInfoWin.instance;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ColonyLogo()
        {
            mx_internal::_document = this;
            this.width = 60;
            this.height = 33;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___ColonyLogo_Canvas1_creationComplete);
            this.addEventListener("click", ___ColonyLogo_Canvas1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonyLogo._watcherSetupUtil = _arg_1;
        }


        private function init():void
        {
            this.addEventListener(MouseEvent.ROLL_OVER, logoOverHandle);
            this.addEventListener(MouseEvent.ROLL_OUT, logoOutHandle);
            this.addEventListener(MouseEvent.MOUSE_MOVE, logoMoveHandle);
        }

        public function set Parent(_arg_1:AllCastleFrame):void
        {
            this._parent = _arg_1;
        }

        private function _ColonyLogo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return ((this.colonyBean.logoUrl == null) ? "images/icon/cityLogo/citylogo_01.png" : this.colonyBean.logoUrl);
            }, function (_arg_1:Object):void
            {
                myPhoto.source = _arg_1;
            }, "myPhoto.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.cityName.substr(0, 3);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonyLogo_Label1.text = _arg_1;
            }, "_ColonyLogo_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Array
            {
                return ([new GlowFilter(0xFFFFFF, 1, 4, 4, 8, 1, false, false)]);
            }, function (_arg_1:Array):void
            {
                _ColonyLogo_Label1.filters = _arg_1;
            }, "_ColonyLogo_Label1.filters");
            result[2] = binding;
            return (result);
        }

        private function logoOverHandle(_arg_1:MouseEvent):void
        {
            var _local_2:Boolean;
            if (((this.colonyBean.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED) || (this.colonyBean.relation == ColonyConstants.COLONY_RELATION_COLONYING)))
            {
                if (this.castleTooltip != null)
                {
                    if (!this.castleTooltip.isPopUp)
                    {
                        PopUpManager.addPopUp(this.castleTooltip, MainFrame.instance);
                    }
                    else
                    {
                        PopUpManager.bringToFront(this.castleTooltip);
                    };
                };
                _local_2 = true;
                if (this.colonyBean.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED)
                {
                    _local_2 = false;
                };
                this.castleTooltip.setCastleBean(this.colonyBean, _local_2);
            };
        }

        override public function initialize():void
        {
            var target:ColonyLogo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonyLogo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_ColonyLogoWatcherSetupUtil");
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

        private function click():void
        {
            if (this.colonyBean.relation == ColonyConstants.COLONY_RELATION_COLONYING)
            {
                PopUpManager.removePopUp(this._parent.colonyList);
                ColonyInfoWin.getInstance();
                ColonyInfoWin.instance.setColony(colonyBean, this.castleBean, this._colonyNum, this._pageN, this._colonyArr);
            }
            else
            {
                if (this.colonyBean.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED)
                {
                    PopUpManager.removePopUp(this._parent.colonyList);
                    SuzerainInfoWin.getInstance();
                    this.suzInfowin.setCastleBean(this.colonyBean, this.castleBean);
                };
            };
        }

        private function logoOutHandle(_arg_1:MouseEvent):void
        {
            if (((this.colonyBean.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED) || (this.colonyBean.relation == ColonyConstants.COLONY_RELATION_COLONYING)))
            {
                PopUpManager.removePopUp(this.castleTooltip);
            };
        }

        public function ___ColonyLogo_Canvas1_click(_arg_1:MouseEvent):void
        {
            click();
        }

        private function set colonyBean(_arg_1:ColonyBean):void
        {
            var _local_2:Object = this._1197684682colonyBean;
            if (_local_2 !== _arg_1)
            {
                this._1197684682colonyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyBean", _local_2, _arg_1));
            };
        }

        private function set castleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._113836232castleBean;
            if (_local_2 !== _arg_1)
            {
                this._113836232castleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleBean", _local_2, _arg_1));
            };
        }

        public function set pageN(_arg_1:int):void
        {
            this._pageN = _arg_1;
        }

        public function ___ColonyLogo_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set ColonyArr(_arg_1:ArrayCollection):void
        {
            this._colonyArr = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get castleBean():CastleBean
        {
            return (this._113836232castleBean);
        }

        public function set myPhoto(_arg_1:Image):void
        {
            var _local_2:Object = this._1494871014myPhoto;
            if (_local_2 !== _arg_1)
            {
                this._1494871014myPhoto = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myPhoto", _local_2, _arg_1));
            };
        }

        public function set colonyNum(_arg_1:int):void
        {
            this._colonyNum = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get colonyBean():ColonyBean
        {
            return (this._1197684682colonyBean);
        }

        [Bindable(event="propertyChange")]
        public function get myPhoto():Image
        {
            return (this._1494871014myPhoto);
        }

        public function set LogoColonyBean(_arg_1:ColonyBean):void
        {
            this.colonyBean = _arg_1;
        }

        private function _ColonyLogo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.colonyBean.logoUrl == null) ? "images/icon/cityLogo/citylogo_01.png" : this.colonyBean.logoUrl);
            _local_1 = this.colonyBean.cityName.substr(0, 3);
            _local_1 = [new GlowFilter(0xFFFFFF, 1, 4, 4, 8, 1, false, false)];
        }

        public function set LogoCastleBean(_arg_1:CastleBean):void
        {
            this.castleBean = _arg_1;
        }

        private function logoMoveHandle(_arg_1:MouseEvent):void
        {
            if (((this.colonyBean.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED) || (this.colonyBean.relation == ColonyConstants.COLONY_RELATION_COLONYING)))
            {
                this.castleTooltip.moveToMouse(_arg_1);
            };
        }


    }
}//package view.castleList

