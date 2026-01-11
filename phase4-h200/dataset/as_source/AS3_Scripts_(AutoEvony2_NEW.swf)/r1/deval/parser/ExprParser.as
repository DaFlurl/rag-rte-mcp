// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.parser.ExprParser

package r1.deval.parser
{
    import r1.deval.rt.ExprFactory;
    import r1.deval.rt.IExpr;
    import r1.deval.rt.CallExpr;
    import r1.deval.rt.ISettable;
    import r1.deval.rt.FunctionDef;
    import r1.deval.rt.Env;
    import r1.deval.rt.Constant;

    public class ExprParser extends ParserConsts 
    {

        protected static const CLEAR_TI_MASK:int = 0xFFFF;
        protected static const TI_AFTER_EOL:int = (1 << 16);
        protected static const TI_CHECK_LABEL:int = (1 << 17);

        private var next_currentFlaggedToken:int;
        protected var exprFactory:ExprFactory;
        protected var currentFlaggedToken:int;
        private var lookaheadName:Boolean;
        protected var ts:TokenStream;

        public function ExprParser()
        {
            this.exprFactory = new ExprFactory();
        }

        protected function propertyName(_arg_1:IExpr, _arg_2:String, _arg_3:Boolean=false, _arg_4:Boolean=false):IExpr
        {
            var _local_6:int;
            var _local_5:IExpr;
            if (matchToken(COLONCOLON))
            {
                _local_5 = exprFactory.createAccessor(null, _arg_2);
                _local_6 = nextToken();
                switch (_local_6)
                {
                    case NAME:
                        _arg_2 = ts.getString();
                        break;
                    case MUL:
                        _arg_2 = "*";
                        break;
                    case LB:
                        _arg_1 = exprFactory.createAccessor(_arg_1, expression(), _local_5, _arg_3, _arg_4);
                        mustMatchToken(RB, "msg.no.bracket.index", "k07");
                        return (_arg_1);
                    default:
                        reportError("msg.no.name.after.coloncolon", "K08");
                        _arg_2 = "?";
                };
            };
            return (exprFactory.createAccessor(_arg_1, _arg_2, _local_5, _arg_3, _arg_4));
        }

        protected function pushbackLookahead():void
        {
            lookaheadName = true;
            next_currentFlaggedToken = currentFlaggedToken;
            currentFlaggedToken = NAME;
        }

        private function argumentList(_arg_1:CallExpr):void
        {
            if (matchToken(RP))
            {
                return;
            };
            do 
            {
                _arg_1.addParam(assignExpr());
            } while (matchToken(COMMA));
            mustMatchToken(RP, "msg.no.paren.arg", "k04");
        }

        protected function assignExpr():IExpr
        {
            var _local_1:IExpr = condExpr();
            var _local_2:int = peekToken();
            if (((FIRST_ASSIGN <= _local_2) && (_local_2 <= LAST_ASSIGN)))
            {
                consumeToken();
                checkAssignable(_local_1);
                _local_1 = exprFactory.createAssignment((_local_1 as ISettable), assignExpr(), _local_2, ts.getLineno());
            };
            return (_local_1);
        }

        protected function nextToken():int
        {
            var _local_1:int = peekToken();
            consumeToken();
            return (_local_1);
        }

        public function codeBug(_arg_1:String):void
        {
            throw (new ParseError(null, _arg_1, ts.getLineno()));
        }

        public function parseExpr(_arg_1:String):IExpr
        {
            initParser(_arg_1);
            return (expression());
        }

        private function xmlInitializer():IExpr
        {
            var _local_3:IExpr;
            var _local_4:IExpr;
            var _local_1:IExpr;
            var _local_2:int = ts.getFirstXMLToken();
            while (true)
            {
                _local_3 = exprFactory.literal(ts.getString());
                switch (_local_2)
                {
                    case internal::XML:
                        mustMatchToken(LC, "msg.syntax", "k02");
                        _local_1 = exprFactory.createAddSubExpr(_local_1, _local_3);
                        if (peekToken() != RC)
                        {
                            _local_4 = expression();
                            if (ts.isXMLAttribute())
                            {
                                _local_4 = exprFactory.createXMLAttrExpr(_local_4);
                            };
                            _local_1 = exprFactory.createAddSubExpr(_local_1, _local_4);
                        };
                        mustMatchToken(RC, "msg.syntax", "k03");
                        break;
                    case XMLEND:
                        return (exprFactory.createXMLLiteralExpr(_local_1, _local_3));
                    default:
                        reportError("msg.syntax", "K05");
                };
                _local_2 = ts.getNextXMLToken();
            };
            return (null); //dead code
        }

        private function unaryExpr():IExpr
        {
            var _local_1:IExpr;
            var _local_2:int = peekToken();
            switch (_local_2)
            {
                case VOID:
                case NOT:
                case BITNOT:
                case TYPEOF:
                case SUB:
                case ADD:
                case INC:
                case DEC:
                case DELETE:
                    consumeToken();
                    _local_1 = unaryExpr();
                    if (((_local_2 == INC) || (_local_2 == DEC)))
                    {
                        checkAssignable(_local_1);
                    };
                    return (exprFactory.createUnaryExpr(_local_1, _local_2));
                case ERROR:
                    consumeToken();
                    break;
                case LT:
                    consumeToken();
                    return (memberExprTail(true, xmlInitializer()));
                default:
                    _local_1 = memberExpr(true);
                    _local_2 = peekTokenOrEOL();
                    while (((_local_2 == INC) || (_local_2 == DEC)))
                    {
                        consumeToken();
                        _local_1 = exprFactory.createUnaryExpr(_local_1, ((_local_2 == INC) ? POSTFIX_INC : POSTFIX_DEC));
                        _local_2 = peekTokenOrEOL();
                    };
                    return (_local_1);
            };
            reportError("msg.syntax", "K04");
            return (null);
        }

        protected function initParser(_arg_1:String):void
        {
            this.ts = new TokenStream(_arg_1);
            this.currentFlaggedToken = EOF;
        }

        private function eqExpr():IExpr
        {
            var _local_1:IExpr = relExpr();
            var _local_2:int = peekToken();
            _loop_1:
            while (true)
            {
                switch (_local_2)
                {
                    case EQ:
                    case NE:
                    case SHEQ:
                    case SHNE:
                        consumeToken();
                        _local_1 = exprFactory.createEqRelExpr(_local_1, relExpr(), _local_2);
                        break;
                    default:
                        break _loop_1;
                };
                _local_2 = peekToken();
            };
            return (_local_1);
        }

        protected function setCheckForLabel():void
        {
            if ((currentFlaggedToken & CLEAR_TI_MASK) != NAME)
            {
                codeBug("K01");
            };
            currentFlaggedToken = (currentFlaggedToken | TI_CHECK_LABEL);
        }

        protected function nextFlaggedToken():int
        {
            peekToken();
            var _local_1:int = currentFlaggedToken;
            consumeToken();
            return (_local_1);
        }

        private function shiftExpr():IExpr
        {
            var _local_1:IExpr = addExpr();
            var _local_2:int = peekToken();
            _loop_1:
            while (true)
            {
                switch (_local_2)
                {
                    case LSH:
                    case URSH:
                    case RSH:
                        consumeToken();
                        _local_1 = exprFactory.createShiftExpr(_local_1, addExpr(), _local_2);
                        break;
                    default:
                        break _loop_1;
                };
                _local_2 = peekToken();
            };
            return (_local_1);
        }

        private function mulExpr():IExpr
        {
            var _local_1:IExpr = unaryExpr();
            var _local_2:int = peekToken();
            _loop_1:
            while (true)
            {
                switch (_local_2)
                {
                    case MUL:
                    case DIV:
                    case MOD:
                        consumeToken();
                        _local_1 = exprFactory.createMulDivModExpr(_local_1, unaryExpr(), _local_2);
                        break;
                    default:
                        break _loop_1;
                };
                _local_2 = peekToken();
            };
            return (_local_1);
        }

        protected function mustMatchToken(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
            if (!matchToken(_arg_1))
            {
                reportError(_arg_2, _arg_3);
            };
        }

        protected function peekToken():int
        {
            if (lookaheadName)
            {
                return (NAME);
            };
            var _local_1:int = currentFlaggedToken;
            if (_local_1 == EOF)
            {
                _local_1 = ts.getToken();
                if (_local_1 == EOL)
                {
                    do 
                    {
                        _local_1 = ts.getToken();
                    } while (_local_1 == EOL);
                    _local_1 = (_local_1 | TI_AFTER_EOL);
                };
                currentFlaggedToken = _local_1;
            };
            return (_local_1 & CLEAR_TI_MASK);
        }

        private function attributeAccess(_arg_1:IExpr=null, _arg_2:Boolean=false):IExpr
        {
            var _local_3:int = nextToken();
            switch (_local_3)
            {
                case NAME:
                    return (propertyName(_arg_1, ts.getString(), true, _arg_2));
                case MUL:
                    return (propertyName(_arg_1, "*", true, _arg_2));
                case LB:
                    _arg_1 = exprFactory.createAccessor(_arg_1, expression(), null, true, _arg_2);
                    mustMatchToken(RB, "msg.no.bracket.index", "k68");
                    return (_arg_1);
                default:
                    reportError("msg.no.name.after.xmlAttr", "K69");
                    return (null);
            };
        }

        protected function peekTokenOrEOL():int
        {
            var _local_1:int = peekToken();
            if ((currentFlaggedToken & TI_AFTER_EOL) != 0)
            {
                _local_1 = EOL;
            };
            return (_local_1);
        }

        private function bitXorExpr():IExpr
        {
            var _local_1:IExpr = bitAndExpr();
            var _local_2:int = peekToken();
            while (_local_2 == BITXOR)
            {
                consumeToken();
                _local_1 = exprFactory.createBitExpr(_local_1, bitAndExpr(), BITXOR);
                _local_2 = peekToken();
            };
            return (_local_1);
        }

        protected function consumeToken():void
        {
            if (lookaheadName)
            {
                lookaheadName = false;
                currentFlaggedToken = next_currentFlaggedToken;
                return;
            };
            currentFlaggedToken = EOF;
        }

        private function bitOrExpr():IExpr
        {
            var _local_1:IExpr = bitXorExpr();
            var _local_2:int = peekToken();
            while (_local_2 == BITOR)
            {
                consumeToken();
                _local_1 = exprFactory.createBitExpr(_local_1, bitXorExpr(), BITOR);
                _local_2 = peekToken();
            };
            return (_local_1);
        }

        private function bitAndExpr():IExpr
        {
            var _local_1:IExpr = eqExpr();
            var _local_2:int = peekToken();
            while (_local_2 == BITAND)
            {
                consumeToken();
                _local_1 = exprFactory.createBitExpr(_local_1, eqExpr(), BITAND);
                _local_2 = peekToken();
            };
            return (_local_1);
        }

        protected function expression():IExpr
        {
            var _local_1:IExpr = assignExpr();
            while (matchToken(COMMA))
            {
                _local_1 = exprFactory.createExprList(_local_1, assignExpr());
            };
            return (_local_1);
        }

        protected function parseFunction(_arg_1:Boolean=false):FunctionDef
        {
            reportError("msg.function.expr.not.supported", "K09");
            return (null);
        }

        private function andExpr():IExpr
        {
            var _local_3:int;
            var _local_4:Boolean;
            var _local_1:IExpr = bitOrExpr();
            var _local_2:int = peekToken();
            if (((_local_2 == AND) || (_local_2 == NAND)))
            {
                _local_3 = _local_2;
                _local_4 = (_local_2 == NAND);
                while (_local_2 == _local_3)
                {
                    consumeToken();
                    _local_1 = exprFactory.createAndOrExpr(_local_1, andExpr(), true, _local_4);
                    _local_2 = peekToken();
                };
            };
            return (_local_1);
        }

        private function relExpr():IExpr
        {
            var _local_1:IExpr = shiftExpr();
            var _local_2:int = peekToken();
            _loop_1:
            while (true)
            {
                switch (_local_2)
                {
                    case IS:
                    case INSTANCEOF:
                    case IN:
                    case AS:
                        consumeToken();
                        _local_1 = exprFactory.createIsInAsExpr(_local_1, shiftExpr(), _local_2);
                        break _loop_1;
                    case LE:
                    case LT:
                    case GE:
                    case GT:
                        consumeToken();
                        _local_1 = exprFactory.createEqRelExpr(_local_1, shiftExpr(), _local_2);
                        break;
                    default:
                        break _loop_1;
                };
                _local_2 = peekToken();
            };
            return (_local_1);
        }

        private function memberExpr(_arg_1:Boolean):IExpr
        {
            var _local_2:IExpr;
            if (peekToken() == NEW)
            {
                consumeToken();
                _local_2 = exprFactory.createNewExpr(memberExpr(false));
                if (matchToken(LP))
                {
                    argumentList((_local_2 as CallExpr));
                };
            }
            else
            {
                _local_2 = primaryExpr();
            };
            return (memberExprTail(_arg_1, _local_2));
        }

        private function checkAssignable(_arg_1:*):void
        {
            if (!(_arg_1 is ISettable))
            {
                reportError("msg.not.assignable", "K03");
            };
        }

        public function reportError(_arg_1:String, _arg_2:String, _arg_3:String=null, _arg_4:String=null, _arg_5:String=null):void
        {
            throw (new ParseError(Env.getMessage(_arg_1, _arg_3, _arg_4, _arg_5), _arg_2, ts.getLineno()));
        }

        private function memberExprTail(_arg_1:Boolean, _arg_2:IExpr):IExpr
        {
            var _local_3:int;
            var _local_4:Boolean;
            _loop_1:
            while (true)
            {
                _local_3 = peekToken();
                switch (_local_3)
                {
                    case DOT:
                    case DOTDOT:
                        consumeToken();
                        _local_4 = (_local_3 == DOTDOT);
                        _local_3 = nextToken();
                        switch (_local_3)
                        {
                            case NAME:
                                _arg_2 = propertyName(_arg_2, ts.getString(), _local_4);
                                break;
                            case MUL:
                                _arg_2 = propertyName(_arg_2, "*", _local_4);
                                break;
                            case XMLATTR:
                                _arg_2 = attributeAccess(_arg_2, _local_4);
                                break;
                            default:
                                reportError("msg.no.name.after.dot", "K06");
                        };
                        break;
                    case DOTQUERY:
                        consumeToken();
                        _arg_2 = exprFactory.createDotQuery(_arg_2, expression());
                        mustMatchToken(RP, "msg.no.paren", "k05");
                        break;
                    case LB:
                        consumeToken();
                        _arg_2 = exprFactory.createAccessor(_arg_2, expression());
                        mustMatchToken(RB, "msg.no.bracket.index", "k06");
                        break;
                    case LP:
                        if (!_arg_1) break _loop_1;
                        consumeToken();
                        _arg_2 = exprFactory.createCallExpr(_arg_2);
                        argumentList((_arg_2 as CallExpr));
                        break;
                    default:
                        break _loop_1;
                };
            };
            return (_arg_2);
        }

        private function addExpr():IExpr
        {
            var _local_1:IExpr = mulExpr();
            var _local_2:int = peekToken();
            while (((_local_2 == ADD) || (_local_2 == SUB)))
            {
                consumeToken();
                _local_1 = exprFactory.createAddSubExpr(_local_1, mulExpr(), (_local_2 == ADD));
                _local_2 = peekToken();
            };
            return (_local_1);
        }

        private function condExpr():IExpr
        {
            var _local_2:IExpr;
            var _local_1:IExpr = orExpr();
            if (matchToken(HOOK))
            {
                _local_2 = assignExpr();
                mustMatchToken(COLON, "msg.no.colon.cond", "k01");
                _local_1 = exprFactory.createCondExpr(_local_1, _local_2, assignExpr());
            };
            return (_local_1);
        }

        private function orExpr():IExpr
        {
            var _local_3:int;
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_1:IExpr = andExpr();
            var _local_2:int = peekToken();
            if ((((_local_2 == OR) || (_local_2 == NOR)) || (_local_2 == XOR)))
            {
                _local_3 = _local_2;
                _local_4 = (_local_2 == NOR);
                _local_5 = (_local_2 == XOR);
                while (_local_2 == _local_3)
                {
                    consumeToken();
                    _local_1 = exprFactory.createAndOrExpr(_local_1, orExpr(), false, _local_4, _local_5);
                    _local_2 = peekToken();
                };
            };
            return (_local_1);
        }

        private function primaryExpr():IExpr
        {
            var _local_2:IExpr;
            var _local_3:Array;
            var _local_6:Boolean;
            var _local_7:Object;
            var _local_8:String;
            var _local_9:String;
            var _local_10:*;
            var _local_1:Boolean = true;
            var _local_4:int = nextFlaggedToken();
            var _local_5:* = (_local_4 & CLEAR_TI_MASK);
            switch (_local_5)
            {
                case FUNCTION:
                    return (parseFunction(true));
                case LB:
                    _local_3 = [];
                    _local_6 = true;
                    while (true)
                    {
                        _local_5 = peekToken();
                        if (_local_5 == COMMA)
                        {
                            consumeToken();
                            if (!_local_6)
                            {
                                _local_6 = true;
                            }
                            else
                            {
                                _local_3.push(Constant.NULL);
                            };
                        }
                        else
                        {
                            if (_local_5 == RB)
                            {
                                consumeToken();
                                break;
                            };
                            if (!_local_6)
                            {
                                reportError("msg.no.bracket.arg", "K10");
                            };
                            _local_6 = false;
                            _local_2 = assignExpr();
                            if ((_local_2 is Constant))
                            {
                                _local_3.push((_local_2 as Constant).getAny());
                            }
                            else
                            {
                                _local_3.push(_local_2);
                                _local_1 = false;
                            };
                        };
                    };
                    return (exprFactory.createObjectInit(_local_3, _local_1));
                case LC:
                    _local_7 = {};
                    _local_3 = [];
                    if (!matchToken(LC))
                    {
                        _loop_1:
                        do 
                        {
                            _local_5 = peekToken();
                            switch (_local_5)
                            {
                                case NAME:
                                case STRING:
                                    consumeToken();
                                    _local_10 = ts.getString();
                                    _local_3.push(_local_10);
                                    break;
                                case NUMBER:
                                    consumeToken();
                                    _local_10 = ts.getNumber();
                                    _local_3.push(_local_10);
                                    break;
                                case RC:
                                    break _loop_1;
                                default:
                                    reportError("msg.bad.prop", "K11");
                                    break _loop_1;
                            };
                            mustMatchToken(COLON, "msg.no.colon.prop", "k08");
                            _local_2 = assignExpr();
                            if ((_local_2 is Constant))
                            {
                                _local_7[_local_10] = (_local_2 as Constant).getAny();
                            }
                            else
                            {
                                _local_7[_local_10] = _local_2;
                                _local_1 = false;
                            };
                        } while (matchToken(COMMA));
                        mustMatchToken(RC, "msg.no.brace.prop", "k09");
                    };
                    return (exprFactory.createObjectInit(_local_7, _local_1, _local_3));
                case LP:
                    _local_2 = expression();
                    mustMatchToken(RP, "msg.no.paren", "k10");
                    return (_local_2);
                case XMLATTR:
                    return (attributeAccess());
                case NAME:
                    _local_8 = ts.getString();
                    if (((!((_local_4 & TI_CHECK_LABEL) == 0)) && (peekToken() == COLON)))
                    {
                        consumeToken();
                        return (new Label(_local_8));
                    };
                    return (propertyName(null, _local_8));
                case THIS:
                    consumeToken();
                    return (exprFactory.thisExpr());
                case NULL:
                    return (exprFactory.literal(null));
                case FALSE:
                    return (exprFactory.literal(false));
                case TRUE:
                    return (exprFactory.literal(true));
                case NUMBER:
                    return (exprFactory.literal(ts.getNumber()));
                case STRING:
                    return (exprFactory.literal(ts.getString()));
                case DIV:
                case ASSIGN_DIV:
                    ts.readRegExp(_local_5);
                    _local_9 = ts.regExpFlags;
                    ts.regExpFlags = null;
                    return (exprFactory.regExp(ts.getString(), _local_9));
                case RESERVED:
                    reportError("msg.reserved.id", "K12");
                    break;
                case EOF:
                    reportError("msg.unexpected.eof", "K13");
                    break;
                case ERROR:
                default:
                    reportError("msg.syntax", "K14");
            };
            return (null);
        }

        protected function peekFlaggedToken():int
        {
            peekToken();
            return (currentFlaggedToken);
        }

        protected function matchToken(_arg_1:int):Boolean
        {
            var _local_2:int = peekToken();
            if (_local_2 != _arg_1)
            {
                return (false);
            };
            consumeToken();
            return (true);
        }

        protected function eof():Boolean
        {
            return (ts.eof());
        }


    }
}//package r1.deval.parser

