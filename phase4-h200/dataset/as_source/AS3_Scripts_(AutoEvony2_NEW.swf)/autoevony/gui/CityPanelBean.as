// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.CityPanelBean

package autoevony.gui
{
    import mx.containers.Canvas;
    import autoevony.gui.newarmy.NewArmyWin;
    import flash.net.SharedObject;
    import autoevony.common.Utils;
    import autoevony.player.LoginHelper;
    import mx.events.PropertyChangeEvent;

    public class CityPanelBean extends Canvas 
    {

        internal static const ICON_TYPE_NONE:int = 0;
        internal static const ICON_TYPE_SUZ:int = 1;
        internal static const ICON_TYPE_COL:int = 2;
        private static const SUZ_ICON:Class = CityPanelBean_SUZ_ICON;
        private static const COL_ICON:Class = CityPanelBean_COL_ICON;

        internal var lastSavedScriptFileName:String = null;
        private var _1691131734scriptIsRunning:Boolean;
        internal var lastLoadedGoalsFileName:String = null;
        private var isSuz:Boolean;
        public var marchWin:NewArmyWin;
        private var _249938341scriptTxt:String;
        private var _35872819castleId:int;
        private var isCol:Boolean;
        internal var lastLoadedScriptFileName:String = null;
        private var _1729777296goalsTxt:String;
        internal var lastSavedGoalsFileName:String = null;

        public function CityPanelBean(_arg_1:int, _arg_2:String="", _arg_3:int=-1)
        {
            this.castleId = _arg_1;
            this.label = _arg_2;
            if (_arg_3 != -1)
            {
                this.setTabIcon(_arg_3);
            }
            else
            {
                this.icon = null;
            };
            this.goalsTxt = "";
            this.scriptTxt = "";
            this.isSuz = false;
            this.isCol = false;
            this.scriptIsRunning = false;
            this.marchWin = null;
        }

        internal function setTabIcon(_arg_1:int):void
        {
            if (_arg_1 == ICON_TYPE_NONE)
            {
                if (((this.isSuz) || (this.isCol)))
                {
                    this.icon = null;
                    this.isSuz = false;
                    this.isCol = false;
                };
            }
            else
            {
                if (_arg_1 == ICON_TYPE_SUZ)
                {
                    if (!this.isSuz)
                    {
                        this.icon = SUZ_ICON;
                        this.isSuz = true;
                        this.isCol = false;
                    };
                }
                else
                {
                    if (_arg_1 == ICON_TYPE_COL)
                    {
                        if (!this.isCol)
                        {
                            this.icon = COL_ICON;
                            this.isSuz = false;
                            this.isCol = true;
                        };
                    };
                };
            };
        }

        internal function onLoadScript(_arg_1:Object=null, _arg_2:int=500):void
        {
            if (Snippets.isInitialized)
            {
                this.scriptTxt = SharedObject.getLocal(("citytab" + this.castleId)).data.now;
                if (this.scriptTxt == null)
                {
                    this.scriptTxt = "";
                };
                if (((LoginHelper.getInstance().autoScript) && (!(Utils.trim(this.scriptTxt) == ""))))
                {
                    Utils.callLater(_arg_2, MainScreen.getInstance()._cityPanel.onRunScript, [this.castleId]);
                };
            }
            else
            {
                Utils.callLater(50, this.onLoadScript, [_arg_1, _arg_2]);
            };
        }

        public function set scriptTxt(_arg_1:String):void
        {
            var _local_2:Object = this._249938341scriptTxt;
            if (_local_2 !== _arg_1)
            {
                this._249938341scriptTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scriptTxt", _local_2, _arg_1));
            };
        }

        public function set scriptIsRunning(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1691131734scriptIsRunning;
            if (_local_2 !== _arg_1)
            {
                this._1691131734scriptIsRunning = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scriptIsRunning", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get goalsTxt():String
        {
            return (this._1729777296goalsTxt);
        }

        public function set goalsTxt(_arg_1:String):void
        {
            var _local_2:Object = this._1729777296goalsTxt;
            if (_local_2 !== _arg_1)
            {
                this._1729777296goalsTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goalsTxt", _local_2, _arg_1));
            };
        }

        internal function onLoadGoals(_arg_1:Object=null, _arg_2:int=20):void
        {
            if (Snippets.isInitialized)
            {
                this.goalsTxt = SharedObject.getLocal(("citygoals" + this.castleId)).data.now;
                if (this.goalsTxt == null)
                {
                    this.goalsTxt = "";
                };
                if (LoginHelper.getInstance().autoRun)
                {
                    Utils.callLater(_arg_2, MainScreen.getInstance()._cityPanel.onSetGoals, [this.castleId]);
                };
            }
            else
            {
                Utils.callLater(50, this.onLoadGoals, [_arg_1, _arg_2]);
            };
        }

        [Bindable(event="propertyChange")]
        public function get scriptTxt():String
        {
            return (this._249938341scriptTxt);
        }

        public function set castleId(_arg_1:int):void
        {
            var _local_2:Object = this._35872819castleId;
            if (_local_2 !== _arg_1)
            {
                this._35872819castleId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleId", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get scriptIsRunning():Boolean
        {
            return (this._1691131734scriptIsRunning);
        }

        [Bindable(event="propertyChange")]
        public function get castleId():int
        {
            return (this._35872819castleId);
        }


    }
}//package autoevony.gui

