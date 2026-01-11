// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.HeroLabel

package view.module.herosMansion
{
    import mx.controls.Label;
    import com.evony.Lang;
    import com.evony.common.constants.HeroConstants;
    import com.evony.eum.ItemEumDefine;

    public class HeroLabel extends Label 
    {

        public function HeroLabel()
        {
            this.styleName = "tableContent2";
        }

        override public function initialize():void
        {
            super.initialize();
        }

        public function set office(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case HeroConstants.HERO_FREE_STATU:
                    this.text = Lang.msg("空闲");
                    return;
                case HeroConstants.HERO_CHIEF_STATU:
                    this.text = Lang.msg("城守");
                    return;
                case HeroConstants.HERO_GUARD_STATU:
                    this.text = Lang.msg("驻守");
                    return;
                case HeroConstants.HERO_SEND_STATU:
                    this.text = Lang.msg("出征");
                    return;
                case 8:
                    this.text = "Farming";
                    return;
                case HeroConstants.HERO_SEIZED_STATU:
                    this.text = Lang.msg("俘虏");
                    return;
                case HeroConstants.HERO_BACK_STATU:
                    this.text = Lang.msg("军队返回");
                    return;
            };
        }

        public function set goodName(_arg_1:String):void
        {
            this.text = ItemEumDefine.getItemEum(_arg_1).name;
        }


    }
}//package view.module.herosMansion

