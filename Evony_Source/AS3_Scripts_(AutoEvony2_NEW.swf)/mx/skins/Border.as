// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.Border

package mx.skins
{
    import mx.core.IBorder;
    import mx.core.EdgeMetrics;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class Border extends ProgrammaticSkin implements IBorder 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";


        public function get borderMetrics():EdgeMetrics
        {
            return (EdgeMetrics.EMPTY);
        }


    }
}//package mx.skins

