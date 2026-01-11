// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.world.CastleFlagMc

package view.castle.world
{
    import com.evony.util.EvonyAnimation;
    import com.evony.Context;
    import com.evony.common.constants.DeclaredWarConstants;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.common.beans.MapCastleBean;

    public class CastleFlagMc extends EvonyAnimation 
    {

        public function CastleFlagMc()
        {
            this.load(TYPE_Banner, -1);
            this.gotoAndStopNative(1);
        }

        public function setMapCastleBean(_arg_1:MapCastleBean, _arg_2:Boolean=false):void
        {
            if (!_arg_1.npc)
            {
                if (_arg_1.userName == Context.getInstance().getPlayerBean().playerInfo.userName)
                {
                    this.gotoAndStopNative("yellow_s");
                }
                else
                {
                    if (((_arg_1.relation == AllianceConstants.ENEMY_ALLIANCE) || (_arg_1.declaredWarStatus == DeclaredWarConstants.STATUS_WAR)))
                    {
                        this.gotoAndStopNative("red_s");
                    }
                    else
                    {
                        if (_arg_1.relation == AllianceConstants.FRIEND_ALLIANCE)
                        {
                            this.gotoAndStopNative("blue_s");
                        }
                        else
                        {
                            if (_arg_1.relation == AllianceConstants.SAME_ALLIANCE)
                            {
                                this.gotoAndStopNative("green_s");
                            }
                            else
                            {
                                if (_arg_1.declaredWarStatus == DeclaredWarConstants.STATUS_PREPARATIONS)
                                {
                                    this.gotoAndStopNative("purple_s");
                                }
                                else
                                {
                                    this.gotoAndStopNative("white_s");
                                };
                            };
                        };
                    };
                };
            }
            else
            {
                this.gotoAndStopNative("orange_s");
            };
        }


    }
}//package view.castle.world

