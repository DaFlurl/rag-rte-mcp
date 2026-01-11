// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.AllCastleView

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.client.response.ResponseDispatcher;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.beans.PlayerBean;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.HeroBean;
    import mx.controls.DataGrid;
    import mx.core.UIComponentDescriptor;
    import com.evony.Lang;
    import mx.collections.ArrayCollection;
    import view.module.herosMansion.HeroProperties;
    import com.evony.Context;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import com.evony.common.module.CommandResponse;
    import com.evony.Coordinate;
    import com.evony.common.module.hero.HeroResponse;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import mx.events.FlexEvent;
    import mx.core.ClassFactory;
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

    public class AllCastleView extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var instance:ResponseDispatcher;
        public var _AllCastleView_DataGridColumn1:DataGridColumn;
        public var _AllCastleView_DataGridColumn2:DataGridColumn;
        public var _AllCastleView_DataGridColumn3:DataGridColumn;
        public var _AllCastleView_DataGridColumn4:DataGridColumn;
        public var _AllCastleView_DataGridColumn5:DataGridColumn;
        public var _AllCastleView_DataGridColumn6:DataGridColumn;
        private var _985752863player:PlayerBean;
        private var giveUpCastle:GiveupCastle;
        private var _691506344curCastle:CastleBean;
        private var chiefHero:HeroBean = null;
        private var _35872635castleDG:DataGrid;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"castleDG",
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "rowHeight":37,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "percentWidth":100,
                                "percentHeight":100,
                                "columns":[_AllCastleView_DataGridColumn1_i(), _AllCastleView_DataGridColumn2_i(), _AllCastleView_DataGridColumn3_i(), _AllCastleView_DataGridColumn4_i(), _AllCastleView_DataGridColumn5_i(), _AllCastleView_DataGridColumn6_i()]
                            });
                        }
                    })]});
            }
        });
        private var _1285154777trashStr:String = Lang.msg("废弃");
        private var _1112050249castleArr:ArrayCollection = new ArrayCollection();
        private var heroProperty:HeroProperties = new HeroProperties();
        private var chiefHeroArr:Array = [];
        private var dataP:ArrayCollection = Context.getInstance().getCurCastle().herosArray;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllCastleView()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.styleName = "baseBackGround";
            this.addEventListener("creationComplete", ___AllCastleView_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllCastleView._watcherSetupUtil = _arg_1;
        }


        public function seeAbout(_arg_1:MouseEvent):void
        {
            var _local_3:HeroBean;
            var _local_5:String;
            var _local_2:String = _arg_1.target.text;
            var _local_4:int;
            while (_local_4 < chiefHeroArr.length)
            {
                _local_5 = chiefHeroArr[_local_4].name;
                if (_local_2 == _local_5)
                {
                    _local_3 = chiefHeroArr[_local_4];
                };
                _local_4++;
            };
            if (_local_2 != "--")
            {
                chiefHero = _local_3;
            }
            else
            {
                chiefHero = null;
            };
            if (chiefHero != null)
            {
                if (!heroProperty.isPopUp)
                {
                    PopUpManager.addPopUp(heroProperty, MainFrame.instance, false);
                };
                heroProperty._heroList = dataP;
                heroProperty._heroMes = chiefHero;
            };
        }

        private function giveUpCastleResponse(_arg_1:CommandResponse):void
        {
            setCastleArr();
        }

        private function setCastleArr():void
        {
            var _local_2:CastleBean;
            var _local_3:Coordinate;
            var _local_4:String;
            var _local_5:String;
            var _local_6:int;
            var _local_7:HeroBean;
            castleArr.removeAll();
            var _local_1:int;
            while (_local_1 < this.player.castlesArray.length)
            {
                _local_2 = this.player.getCastles(_local_1);
                _local_3 = new Coordinate(_local_2.fieldId);
                _local_4 = (((("(" + _local_3.x) + ",") + _local_3.y) + ")");
                _local_5 = "--";
                _local_6 = 0;
                while (_local_6 < _local_2.herosArray.length)
                {
                    _local_7 = _local_2.getHeros(_local_6);
                    if (_local_7.status == HeroResponse.CHIEF_HERO_STATUS)
                    {
                        _local_5 = _local_7.name;
                        chiefHeroArr.push(_local_7);
                        break;
                    };
                    _local_6++;
                };
                castleArr.addItem({
                    "id":_local_2.id,
                    "castleName":_local_2.name,
                    "location":_local_4,
                    "hero":_local_5,
                    "population":_local_2.resource.curPopulation,
                    "support":_local_2.resource.support
                });
                _local_1++;
            };
        }

        override public function initialize():void
        {
            var target:AllCastleView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllCastleView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_AllCastleViewWatcherSetupUtil");
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

        private function set castleArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1112050249castleArr;
            if (_local_2 !== _arg_1)
            {
                this._1112050249castleArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleArr", _local_2, _arg_1));
            };
        }

        private function _AllCastleView_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllCastleView_DataGridColumn2 = _local_1;
            _local_1.dataField = "location";
            _local_1.width = 100;
            _local_1.setStyle("fontSize", 12);
            BindingManager.executeBindings(this, "_AllCastleView_DataGridColumn2", _AllCastleView_DataGridColumn2);
            return (_local_1);
        }

        private function _AllCastleView_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllCastleView_DataGridColumn4 = _local_1;
            _local_1.dataField = "population";
            _local_1.width = 100;
            _local_1.setStyle("fontSize", 12);
            BindingManager.executeBindings(this, "_AllCastleView_DataGridColumn4", _AllCastleView_DataGridColumn4);
            return (_local_1);
        }

        private function _AllCastleView_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllCastleView_DataGridColumn6 = _local_1;
            _local_1.width = 100;
            _local_1.itemRenderer = _AllCastleView_ClassFactory3_c();
            BindingManager.executeBindings(this, "_AllCastleView_DataGridColumn6", _AllCastleView_DataGridColumn6);
            return (_local_1);
        }

        public function init():void
        {
            instance = ResponseDispatcher.getInstance();
            instance.addEventListener(ResponseDispatcher.CITY_GIVEUP_CASTLE, giveUpCastleResponse);
            this.player = Context.getInstance().getPlayerBean();
            this.curCastle = Context.getInstance().getCurCastle();
            this.setCastleArr();
        }

        public function set castleBean(_arg_1:CastleBean):void
        {
            this.curCastle = _arg_1;
            setCastleArr();
        }

        public function set trashStr(_arg_1:String):void
        {
            var _local_2:Object = this._1285154777trashStr;
            if (_local_2 !== _arg_1)
            {
                this._1285154777trashStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "trashStr", _local_2, _arg_1));
            };
        }

        private function set curCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._691506344curCastle;
            if (_local_2 !== _arg_1)
            {
                this._691506344curCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastle", _local_2, _arg_1));
            };
        }

        public function castleView(_arg_1:MouseEvent):void
        {
            GiveupCastle.show(this.curCastle, _arg_1.target.data.id, _arg_1.target.data.castleName);
        }

        private function _AllCastleView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = castleArr;
            _local_1 = Lang.msg("城池");
            _local_1 = Lang.msg("位置");
            _local_1 = Lang.msg("城守");
            _local_1 = Lang.msg("人口");
            _local_1 = Lang.msg("民心");
            _local_1 = Lang.msg("行为");
        }

        public function ___AllCastleView_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _AllCastleView_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllCastleView_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function set player(_arg_1:PlayerBean):void
        {
            var _local_2:Object = this._985752863player;
            if (_local_2 !== _arg_1)
            {
                this._985752863player = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "player", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get castleArr():ArrayCollection
        {
            return (this._1112050249castleArr);
        }

        private function _AllCastleView_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllCastleView_DataGridColumn1 = _local_1;
            _local_1.dataField = "castleName";
            _local_1.width = 130;
            _local_1.itemRenderer = _AllCastleView_ClassFactory1_c();
            BindingManager.executeBindings(this, "_AllCastleView_DataGridColumn1", _AllCastleView_DataGridColumn1);
            return (_local_1);
        }

        private function _AllCastleView_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllCastleView_DataGridColumn3 = _local_1;
            _local_1.dataField = "hero";
            _local_1.width = 100;
            _local_1.itemRenderer = _AllCastleView_ClassFactory2_c();
            BindingManager.executeBindings(this, "_AllCastleView_DataGridColumn3", _AllCastleView_DataGridColumn3);
            return (_local_1);
        }

        private function _AllCastleView_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllCastleView_DataGridColumn5 = _local_1;
            _local_1.dataField = "support";
            _local_1.width = 60;
            _local_1.setStyle("fontSize", 12);
            BindingManager.executeBindings(this, "_AllCastleView_DataGridColumn5", _AllCastleView_DataGridColumn5);
            return (_local_1);
        }

        public function refresh():void
        {
            trace((this.className + ".refresh()"));
            this.player = Context.getInstance().getPlayerBean();
            this.curCastle = Context.getInstance().getCurCastle();
            this.setCastleArr();
            dataP = Context.getInstance().getCurCastle().herosArray;
        }

        public function set playerBean(_arg_1:PlayerBean):void
        {
            this.player = _arg_1;
        }

        private function _AllCastleView_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllCastleView_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        [Bindable(event="propertyChange")]
        public function get trashStr():String
        {
            return (this._1285154777trashStr);
        }

        private function rebackHandle(_arg_1:MouseEvent):void
        {
            if (this.parent != null)
            {
                this.parentDocument.officeViewstack.selectedChild = this.parentDocument.constructionView;
            };
        }

        [Bindable(event="propertyChange")]
        private function get player():PlayerBean
        {
            return (this._985752863player);
        }

        private function _AllCastleView_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllCastleView_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function destroy():void
        {
            if (GiveupCastle.instancePopup)
            {
                PopUpManager.removePopUp(GiveupCastle.instancePopup);
            };
        }

        [Bindable(event="propertyChange")]
        public function get castleDG():DataGrid
        {
            return (this._35872635castleDG);
        }

        public function set castleDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._35872635castleDG;
            if (_local_2 !== _arg_1)
            {
                this._35872635castleDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleDG", _local_2, _arg_1));
            };
        }

        private function _AllCastleView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (castleArr);
            }, function (_arg_1:Object):void
            {
                castleDG.dataProvider = _arg_1;
            }, "castleDG.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城池");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllCastleView_DataGridColumn1.headerText = _arg_1;
            }, "_AllCastleView_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("位置");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllCastleView_DataGridColumn2.headerText = _arg_1;
            }, "_AllCastleView_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城守");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllCastleView_DataGridColumn3.headerText = _arg_1;
            }, "_AllCastleView_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人口");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllCastleView_DataGridColumn4.headerText = _arg_1;
            }, "_AllCastleView_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("民心");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllCastleView_DataGridColumn5.headerText = _arg_1;
            }, "_AllCastleView_DataGridColumn5.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("行为");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllCastleView_DataGridColumn6.headerText = _arg_1;
            }, "_AllCastleView_DataGridColumn6.headerText");
            result[6] = binding;
            return (result);
        }


    }
}//package view.module.office

