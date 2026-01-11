// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.CreatPlayerMap

package view.ui
{
    import mx.containers.Canvas;
    import flash.display.MovieClip;
    import mx.core.UIComponentDescriptor;
    import mx.core.UIComponent;
    import mx.core.mx_internal;
    import com.evony.MsgDispacther;
    import view.CreatPlayerPanel;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;

    public class CreatPlayerMap extends Canvas 
    {

        private var areaId:int;
        private var selected:Boolean;
        private var _mapName:String;
        private var mapMC:MovieClip;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":140,
                    "height":130
                });
            }
        });
        private var Bavaria:Class = CreatPlayerMap_Bavaria;
        private var Bohemia:Class = CreatPlayerMap_Bohemia;
        private var Burgundy:Class = CreatPlayerMap_Burgundy;
        private var Carinthia:Class = CreatPlayerMap_Carinthia;
        private var Franconia:Class = CreatPlayerMap_Franconia;
        private var Friesland:Class = CreatPlayerMap_Friesland;
        private var Lombardy:Class = CreatPlayerMap_Lombardy;
        private var Lower:Class = CreatPlayerMap_Lower;
        private var Moravia:Class = CreatPlayerMap_Moravia;
        private var NorthMarch:Class = CreatPlayerMap_NorthMarch;
        private var Romagna:Class = CreatPlayerMap_Romagna;
        private var Saxony:Class = CreatPlayerMap_Saxony;
        private var Swabia:Class = CreatPlayerMap_Swabia;
        private var Thuringia:Class = CreatPlayerMap_Thuringia;
        private var Tuscany:Class = CreatPlayerMap_Tuscany;
        private var UpperLorraine:Class = CreatPlayerMap_UpperLorraine;
        private var mapContainer:UIComponent = new UIComponent();

        public function CreatPlayerMap()
        {
            mx_internal::_document = this;
            this.width = 140;
            this.height = 130;
            this.addEventListener("creationComplete", ___CreatPlayerMap_Canvas1_creationComplete);
        }

        private function mouseMoveHandle(_arg_1:MouseEvent):void
        {
            MsgDispacther.getInstance().dispatchEvent(new CreatPlayerAreaChangeEvent(CreatPlayerPanel.EVENT_AREA_MOVE, _mapName, areaId, this));
        }

        public function get mapName():String
        {
            return (this._mapName);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function set town(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case "Bavaria":
                    this._mapName = "Bavaria";
                    this.areaId = 10;
                    mapMC = (new Bavaria() as MovieClip);
                    break;
                case "Bohemia":
                    this._mapName = "Bohemia";
                    this.areaId = 3;
                    mapMC = (new Bohemia() as MovieClip);
                    break;
                case "Burgundy":
                    this._mapName = "Burgundy";
                    this.areaId = 12;
                    mapMC = (new Burgundy() as MovieClip);
                    break;
                case "Carinthia":
                    this._mapName = "Carinthia";
                    this.areaId = 11;
                    mapMC = (new Carinthia() as MovieClip);
                    break;
                case "Franconia":
                    this._mapName = "Franconia";
                    this.areaId = 5;
                    mapMC = (new Franconia() as MovieClip);
                    break;
                case "Friesland":
                    this._mapName = "Friesland";
                    this.areaId = 0;
                    mapMC = (new Friesland() as MovieClip);
                    break;
                case "Lombardy":
                    this._mapName = "Lombardy";
                    this.areaId = 13;
                    mapMC = (new Lombardy() as MovieClip);
                    break;
                case "Lower":
                    this._mapName = "Lower";
                    this.areaId = 4;
                    mapMC = (new Lower() as MovieClip);
                    break;
                case "Moravia":
                    this._mapName = "Moravia";
                    this.areaId = 7;
                    mapMC = (new Moravia() as MovieClip);
                    break;
                case "NorthMarch":
                    this._mapName = "NorthMarch";
                    this.areaId = 2;
                    mapMC = (new NorthMarch() as MovieClip);
                    break;
                case "Romagna":
                    this._mapName = "Romagna";
                    this.areaId = 15;
                    mapMC = (new Romagna() as MovieClip);
                    break;
                case "Saxony":
                    this._mapName = "Saxony";
                    this.areaId = 1;
                    mapMC = (new Saxony() as MovieClip);
                    break;
                case "Swabia":
                    this._mapName = "Swabia";
                    this.areaId = 9;
                    mapMC = (new Swabia() as MovieClip);
                    break;
                case "Thuringia":
                    this._mapName = "Thuringia";
                    this.areaId = 6;
                    mapMC = (new Thuringia() as MovieClip);
                    break;
                case "Tuscany":
                    this._mapName = "Tuscany";
                    this.areaId = 14;
                    mapMC = (new Tuscany() as MovieClip);
                    break;
                case "UpperLorraine":
                    this._mapName = "UpperLorraine";
                    this.areaId = 8;
                    mapMC = (new UpperLorraine() as MovieClip);
                    break;
            };
            this.mapMC.gotoAndStop("up");
            this.mapContainer.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandle);
            this.mapContainer.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandle);
            this.mapContainer.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandle);
            this.mapContainer.addEventListener(MouseEvent.CLICK, mouseClickHandle);
            this.mapContainer.addChild(this.mapMC);
            this.mapContainer.hitArea = this.mapMC;
            this.mapMC.mouseEnabled = false;
        }

        private function mouseOverHandle(_arg_1:MouseEvent):void
        {
            if (!selected)
            {
                this.mapMC.gotoAndStop("over");
            };
            MsgDispacther.getInstance().dispatchEvent(new CreatPlayerAreaChangeEvent(CreatPlayerPanel.EVENT_AREA_OVER, _mapName, areaId, this));
        }

        private function init():void
        {
            this.addChild(mapContainer);
            this.selected = false;
        }

        public function gotoSelect():void
        {
            this.mapMC.gotoAndStop("select");
            this.selected = true;
        }

        private function mouseClickHandle(_arg_1:MouseEvent):void
        {
            MsgDispacther.getInstance().dispatchEvent(new CreatPlayerAreaChangeEvent(CreatPlayerPanel.EVENT_AREA_CHANGE, _mapName, areaId, this));
        }

        public function gotoUp():void
        {
            this.mapMC.gotoAndStop("up");
            this.selected = false;
        }

        private function mouseOutHandle(_arg_1:MouseEvent):void
        {
            if (!selected)
            {
                this.mapMC.gotoAndStop("up");
            };
            MsgDispacther.getInstance().dispatchEvent(new CreatPlayerAreaChangeEvent(CreatPlayerPanel.EVENT_AREA_OUT, _mapName, areaId, this));
        }

        public function ___CreatPlayerMap_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }


    }
}//package view.ui

