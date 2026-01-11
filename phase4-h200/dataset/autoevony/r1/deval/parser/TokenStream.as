// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//r1.deval.parser.TokenStream

package r1.deval.parser
{
    import r1.deval.parser.ParserConsts;
    import r1.deval.util.StringBuffer;
    import r1.deval.rt.Env;
    import r1.deval.parser.ParseError;

    internal class TokenStream extends ParserConsts 
    {

        private var xmlIsTagContent:Boolean;
        private var sourceString:String;
        private var string:String = "";
        internal var regExpFlags:String;
        private var stringBuffer:StringBuffer;
        private var lineno:int;
        private var lineEndChar:int = -1;
        private var sourceEnd:int;
        private var ungetBuffer:Array;
        private var number:Number;
        private var lineStart:int = 0;
        private var sourceCursor:int;
        private var ungetCursor:int;
        private var dirtyLine:Boolean;
        private var hitEOF:Boolean = false;
        private var line:String;
        private var xmlOpenTagsCount:int;
        private var xmlIsAttribute:Boolean;

        public function TokenStream(_arg_1:String, _arg_2:int=1)
        {
            this.lineno = _arg_2;
            this.stringBuffer = new StringBuffer();
            this.ungetBuffer = new Array(3);
            this.sourceString = _arg_1;
            this.sourceEnd = _arg_1.length;
            this.sourceCursor = 0;
        }

        private static function isDigit(_arg_1:int):Boolean
        {
            return ((CHAR_0 <= _arg_1) && (_arg_1 <= CHAR_9));
        }

        private static function isIdentifierPart(_arg_1:int):Boolean
        {
            return ((isIdentifierStart(_arg_1)) || ((_arg_1 >= CHAR_0) && (_arg_1 <= CHAR_9)));
        }

        private static function codeBug():void
        {
            Env.reportError(ParseError.codeBugMessage, "KT");
        }

        private static function reportWarning(_arg_1:String, _arg_2:*=null, _arg_3:*=null, _arg_4:*=null):void
        {
            Env.reportWarning(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        private static function isJSLineTerminator(_arg_1:int):Boolean
        {
            if ((_arg_1 & 0xDFD0) != 0)
            {
                return (false);
            };
            return ((((_arg_1 == CHAR_NL) || (_arg_1 == CHAR_CR)) || (_arg_1 == 8232)) || (_arg_1 == 8233));
        }

        private static function isIdentifierStart(_arg_1:int):Boolean
        {
            return ((((_arg_1 >= CHAR_a) && (_arg_1 <= CHAR_z)) || ((_arg_1 >= CHAR_A) && (_arg_1 <= CHAR_Z))) || (_arg_1 == CHAR_UNDERSCORE));
        }

        private static function isJSSpace(_arg_1:int):Boolean
        {
            return (((((_arg_1 == 32) || (_arg_1 == 9)) || (_arg_1 == 12)) || (_arg_1 == 11)) || (_arg_1 == 160));
        }

        private static function isAlpha(_arg_1:int):Boolean
        {
            if (_arg_1 <= CHAR_Z)
            {
                return (CHAR_A <= _arg_1);
            };
            return ((CHAR_a <= _arg_1) && (_arg_1 <= CHAR_z));
        }

        private static function oDigitToInt(_arg_1:int, _arg_2:int):int
        {
            return ((_arg_2 << 3) | (_arg_1 - CHAR_0));
        }

        private static function xDigitToInt(_arg_1:int, _arg_2:int):int
        {
                
            outer_block:
            {

                if (_arg_1 <= CHAR_9)
                {
                    _arg_1 = (_arg_1 - CHAR_0);
                    if (0 <= _arg_1) return ((_arg_2 << 4) | _arg_1); //break outer_block;
                }
                else
                {
                    if (_arg_1 <= CHAR_F)
                    {
                        if (CHAR_A <= _arg_1)
                        {
                            _arg_1 = (_arg_1 - (CHAR_A - 10));
                            return ((_arg_2 << 4) | _arg_1); //break outer_block;
                        };
                    }
                    else
                    {
                        if (_arg_1 <= CHAR_f)
                        {
                            if (CHAR_a <= _arg_1)
                            {
                                _arg_1 = (_arg_1 - (CHAR_a - 10));
                                return ((_arg_2 << 4) | _arg_1); //break outer_block;
                            };
                        };
                    };
                };
                return (-1);
            
            }//outer_block
            return ((_arg_2 << 4) | _arg_1);
        }

        private static function reportError(_arg_1:String):void
        {
            Env.reportError(_arg_1, "KT");
        }

        private static function stringToKeyword(_arg_1:String):int
        {
            var _local_3:String;
            var _local_5:int;
            var _local_6:int;
            var _local_2:int;
            var _local_4:int = _arg_1.length;
            if (_local_4 >= 2)
            {
                _local_5 = _arg_1.charCodeAt(0);
                _local_6 = _arg_1.charCodeAt(1);
                _loop_1:
                switch (_local_4)
                {
                    case 2:
                        switch (_local_5)
                        {
                            case CHAR_a:
                                if (_local_6 == CHAR_s)
                                {
                                    return (AS);
                                };
                                break _loop_1;
                            case CHAR_i:
                                switch (_local_6)
                                {
                                    case CHAR_f:
                                        return (IF);
                                    case CHAR_n:
                                        return (IN);
                                    case CHAR_s:
                                        return (IS);
                                };
                                break _loop_1;
                            case CHAR_d:
                                if (_arg_1.charCodeAt(1) == CHAR_o)
                                {
                                    return (DO);
                                };
                                break _loop_1;
                            case CHAR_o:
                                if (_arg_1.charCodeAt(1) == CHAR_r)
                                {
                                    return (OR);
                                };
                                break _loop_1;
                        };
                        break;
                    case 3:
                        switch (_local_5)
                        {
                            case CHAR_a:
                                _local_3 = "and";
                                _local_2 = AND;
                                break _loop_1;
                            case CHAR_f:
                                _local_3 = "for";
                                _local_2 = FOR;
                                break _loop_1;
                            case CHAR_n:
                                if (_arg_1 == "new")
                                {
                                    return (NEW);
                                };
                                if (_arg_1 == "nor")
                                {
                                    return (NOR);
                                };
                                if (_arg_1 == "not")
                                {
                                    return (NOT);
                                };
                                break _loop_1;
                            case CHAR_t:
                                _local_3 = "try";
                                _local_2 = TRY;
                                break _loop_1;
                            case CHAR_v:
                                _local_3 = "var";
                                _local_2 = VAR;
                                break _loop_1;
                            case CHAR_x:
                                _local_3 = "xor";
                                _local_2 = XOR;
                                break _loop_1;
                        };
                        break;
                    case 4:
                        switch (_local_5)
                        {
                            case CHAR_c:
                                _local_3 = "case";
                                _local_2 = CASE;
                                break _loop_1;
                            case CHAR_e:
                                _local_3 = "else";
                                _local_2 = ELSE;
                                break _loop_1;
                            case CHAR_n:
                                if (_arg_1 == "null")
                                {
                                    return (NULL);
                                };
                                if (_arg_1 == "nand")
                                {
                                    return (NAND);
                                };
                                break _loop_1;
                            case CHAR_t:
                                if (_arg_1 == "true")
                                {
                                    return (TRUE);
                                };
                                if (_arg_1 == "this")
                                {
                                    return (THIS);
                                };
                                break _loop_1;
                            case CHAR_v:
                                _local_3 = "void";
                                _local_2 = VOID;
                                break _loop_1;
                            case CHAR_w:
                                _local_3 = "with";
                                _local_2 = WITH;
                                break _loop_1;
                        };
                        break;
                    case 5:
                        switch (_arg_1.charCodeAt(2))
                        {
                            case CHAR_a:
                                _local_3 = "class";
                                _local_2 = CLASS;
                                break _loop_1;
                            case CHAR_e:
                                _local_3 = "break";
                                _local_2 = BREAK;
                                break _loop_1;
                            case CHAR_i:
                                _local_3 = "while";
                                _local_2 = WHILE;
                                break _loop_1;
                            case CHAR_l:
                                _local_3 = "false";
                                _local_2 = FALSE;
                                break _loop_1;
                            case CHAR_r:
                                _local_3 = "throw";
                                _local_2 = THROW;
                                break _loop_1;
                            case CHAR_t:
                                _local_3 = "catch";
                                _local_2 = CATCH;
                                break _loop_1;
                        };
                        break;
                    case 6:
                        switch (_local_5)
                        {
                            case CHAR_d:
                                _local_3 = "delete";
                                _local_2 = DELETE;
                                break _loop_1;
                            case CHAR_r:
                                _local_3 = "return";
                                _local_2 = RETURN;
                                break _loop_1;
                            case CHAR_i:
                                _local_3 = "import";
                                _local_2 = IMPORT;
                                break _loop_1;
                            case CHAR_s:
                                _local_3 = "switch";
                                _local_2 = SWITCH;
                                break _loop_1;
                            case CHAR_t:
                                _local_3 = "typeof";
                                _local_2 = TYPEOF;
                                break _loop_1;
                        };
                        break;
                    case 7:
                        switch (_local_6)
                        {
                            case CHAR_e:
                                _local_3 = "default";
                                _local_2 = DEFAULT;
                                break _loop_1;
                            case CHAR_i:
                                _local_3 = "finally";
                                _local_2 = FINALLY;
                                break _loop_1;
                        };
                        break;
                    case 8:
                        switch (_local_5)
                        {
                            case CHAR_c:
                                _local_3 = "continue";
                                _local_2 = CONTINUE;
                                break _loop_1;
                            case CHAR_f:
                                _local_3 = "function";
                                _local_2 = FUNCTION;
                                break _loop_1;
                        };
                        break;
                    case 10:
                        if (_arg_1 == "instanceof")
                        {
                            return (INSTANCEOF);
                        };
                };
                if (((!(_local_3 == null)) && (!(_local_3 == _arg_1))))
                {
                    _local_2 = 0;
                };
            };
            return ((_local_2 == 0) ? EOF : (_local_2 & 0xFF));
        }

        private static function isKeyword(_arg_1:String):Boolean
        {
            return (!(EOF == stringToKeyword(_arg_1)));
        }


        final public function getOffset():int
        {
            var _local_1:int = (sourceCursor - lineStart);
            if (lineEndChar >= 0)
            {
                _local_1--;
            };
            return (_local_1);
        }

        final public function getString():String
        {
            return (string);
        }

        public function isXMLAttribute():Boolean
        {
            return (xmlIsAttribute);
        }

        public function ungetChar(_arg_1:int):void
        {
            if (((!(ungetCursor == 0)) && (ungetBuffer[(ungetCursor - 1)] == CHAR_NL)))
            {
                codeBug();
            };
            var _local_2:* = ungetCursor++;
            ungetBuffer[_local_2] = _arg_1;
        }

        public function readPI():Boolean
        {
            var _local_1:int = getChar();
            while (_local_1 != CHAR_EOF)
            {
                addToString(_local_1);
                if (((_local_1 == CHAR_QUESTION) && (peekChar() == CHAR_GT)))
                {
                    _local_1 = getChar();
                    addToString(_local_1);
                    return (true);
                };
                _local_1 = getChar();
            };
            stringBuffer.clear();
            this.string = null;
            reportError("msg.XML.bad.form");
            return (false);
        }

        private function readCDATA():Boolean
        {
            var _local_1:int = getChar();
            while (_local_1 != CHAR_EOF)
            {
                addToString(_local_1);
                if (((_local_1 == CHAR_RBRACKET) && (peekChar() == CHAR_RBRACKET)))
                {
                    _local_1 = getChar();
                    addToString(_local_1);
                    if (peekChar() == CHAR_GT)
                    {
                        _local_1 = getChar();
                        addToString(_local_1);
                        return (true);
                    };
                }
                else
                {
                    _local_1 = getChar();
                };
            };
            stringBuffer.clear();
            this.string = null;
            reportError("msg.XML.bad.form");
            return (false);
        }

        private function readEntity():Boolean
        {
            var _local_1:int = 1;
            var _local_2:int = getChar();
            while (_local_2 != CHAR_EOF)
            {
                addToString(_local_2);
                switch (_local_2)
                {
                    case CHAR_LT:
                        _local_1++;
                        break;
                    case CHAR_GT:
                        _local_1--;
                        if (_local_1 == 0)
                        {
                            return (true);
                        };
                        break;
                };
                _local_2 = getChar();
            };
            stringBuffer.clear();
            this.string = null;
            reportError("msg.XML.bad.form");
            return (false);
        }

        public function skipLine():void
        {
            var _local_1:int;
            do 
            {
            } while (((!((_local_1 = getChar()) == CHAR_EOF)) && (!(_local_1 == CHAR_NL))));
            ungetChar(_local_1);
        }

        public function readRegExp(_arg_1:int):void
        {
            var _local_2:int;
            stringBuffer.clear();
            if (_arg_1 == ASSIGN_DIV)
            {
                addToString(CHAR_EQUAL);
            }
            else
            {
                if (_arg_1 != DIV)
                {
                    codeBug();
                };
            };
            while ((_local_2 = getChar()) != CHAR_SLASH)
            {
                if (((_local_2 == CHAR_NL) || (_local_2 == CHAR_EOF)))
                {
                    ungetChar(_local_2);
                    reportError("msg.unterminated.re.lit");
                };
                if (_local_2 == CHAR_BACKSLASH)
                {
                    addToString(_local_2);
                    _local_2 = getChar();
                };
                addToString(_local_2);
            };
            var _local_3:int = stringBuffer.length;
            while (true)
            {
                if (matchChar(CHAR_g))
                {
                    addToString(CHAR_g);
                }
                else
                {
                    if (matchChar(CHAR_i))
                    {
                        addToString(CHAR_i);
                    }
                    else
                    {
                        if (matchChar(CHAR_m))
                        {
                            addToString(CHAR_m);
                        }
                        else
                        {
                            break;
                        };
                    };
                };
            };
            if (isAlpha(peekChar()))
            {
                reportError("msg.invalid.re.flag");
            };
            this.string = stringBuffer.substring(0, _local_3);
            this.regExpFlags = stringBuffer.substr(_local_3, (stringBuffer.length - _local_3));
        }

        final public function getLineno():int
        {
            return (lineno);
        }

        public function getNextXMLToken():int
        {
            stringBuffer.clear();
            var _local_1:int = getChar();
            while (_local_1 != CHAR_EOF)
            {
                if (xmlIsTagContent)
                {
                    switch (_local_1)
                    {
                        case CHAR_GT:
                            addToString(_local_1);
                            xmlIsTagContent = false;
                            xmlIsAttribute = false;
                            break;
                        case CHAR_SLASH:
                            addToString(_local_1);
                            if (peekChar() == CHAR_GT)
                            {
                                _local_1 = getChar();
                                addToString(_local_1);
                                xmlIsTagContent = false;
                                xmlOpenTagsCount--;
                            };
                            break;
                        case CHAR_LBRACE:
                            ungetChar(_local_1);
                            this.string = getStringFromBuffer();
                            return (internal::XML);
                        case CHAR_QUOTE:
                        case CHAR_DOUBLEQUOTE:
                            addToString(_local_1);
                            if (!readQuotedString(_local_1))
                            {
                                return (ERROR);
                            };
                            break;
                        case CHAR_EQUAL:
                            addToString(_local_1);
                            xmlIsAttribute = true;
                            break;
                        case CHAR_SPACE:
                        case CHAR_TAB:
                        case CHAR_CR:
                        case CHAR_NL:
                            addToString(_local_1);
                            break;
                        default:
                            addToString(_local_1);
                            xmlIsAttribute = false;
                    };
                    if (((!(xmlIsTagContent)) && (xmlOpenTagsCount == 0)))
                    {
                        this.string = getStringFromBuffer();
                        return (XMLEND);
                    };
                }
                else
                {
                    switch (_local_1)
                    {
                        case CHAR_LT:
                            addToString(_local_1);
                            _local_1 = peekChar();
                            switch (_local_1)
                            {
                                case CHAR_BAN:
                                    _local_1 = getChar();
                                    addToString(_local_1);
                                    _local_1 = peekChar();
                                    switch (_local_1)
                                    {
                                        case CHAR_DASH:
                                            _local_1 = getChar();
                                            addToString(_local_1);
                                            _local_1 = getChar();
                                            if (_local_1 == CHAR_DASH)
                                            {
                                                addToString(_local_1);
                                                if (!readXmlComment())
                                                {
                                                    return (ERROR);
                                                };
                                            }
                                            else
                                            {
                                                stringBuffer.clear();
                                                this.string = null;
                                                reportError("msg.XML.bad.form");
                                                return (ERROR);
                                            };
                                            break;
                                        case CHAR_LBRACKET:
                                            _local_1 = getChar();
                                            addToString(_local_1);
                                            if (((((((getChar() == CHAR_C) && (getChar() == CHAR_D)) && (getChar() == CHAR_A)) && (getChar() == CHAR_T)) && (getChar() == CHAR_A)) && (getChar() == CHAR_LBRACKET)))
                                            {
                                                addToString("CDATA[");
                                                if (!readCDATA())
                                                {
                                                    return (ERROR);
                                                };
                                            }
                                            else
                                            {
                                                stringBuffer.clear();
                                                this.string = null;
                                                reportError("msg.XML.bad.form");
                                                return (ERROR);
                                            };
                                            break;
                                        default:
                                            if (!readEntity())
                                            {
                                                return (ERROR);
                                            };
                                    };
                                    break;
                                case CHAR_QUESTION:
                                    _local_1 = getChar();
                                    addToString(_local_1);
                                    if (!readPI())
                                    {
                                        return (ERROR);
                                    };
                                    break;
                                case CHAR_SLASH:
                                    _local_1 = getChar();
                                    addToString(_local_1);
                                    if (xmlOpenTagsCount == 0)
                                    {
                                        stringBuffer.clear();
                                        this.string = null;
                                        reportError("msg.XML.bad.form");
                                        return (ERROR);
                                    };
                                    xmlIsTagContent = true;
                                    xmlOpenTagsCount--;
                                    break;
                                default:
                                    xmlIsTagContent = true;
                                    xmlOpenTagsCount++;
                            };
                            break;
                        case CHAR_LBRACE:
                            ungetChar(_local_1);
                            this.string = getStringFromBuffer();
                            return (internal::XML);
                        default:
                            addToString(_local_1);
                    };
                };
                _local_1 = getChar();
            };
            stringBuffer.clear();
            this.string = null;
            reportError("msg.XML.bad.form");
            return (ERROR);
        }

        public function addToString(_arg_1:*):void
        {
            if ((_arg_1 is String))
            {
                stringBuffer.append(_arg_1);
            }
            else
            {
                stringBuffer.append(String.fromCharCode(int(_arg_1)));
            };
        }

        public function matchChar(_arg_1:int):Boolean
        {
            var _local_2:int = getChar();
            if (_local_2 == _arg_1)
            {
                return (true);
            };
            ungetChar(_local_2);
            return (false);
        }

        public function getFirstXMLToken():int
        {
            xmlOpenTagsCount = 0;
            xmlIsAttribute = false;
            xmlIsTagContent = false;
            ungetChar(CHAR_LT);
            return (getNextXMLToken());
        }

        final public function getNumber():Number
        {
            return (number);
        }

        final public function getToken():int
        {
            var c:int;
            var identifierStart:Boolean;
            var isUnicodeEscapeStart:Boolean;
            var containsEscape:Boolean;
            var str:String;
            var escapeVal:int;
            var i:int;
            var result:int;
            var base:int;
            var isInteger:Boolean;
            var numString:String;
            var dval:Number;
            var lookForSlash:Boolean;
            while (true)
            {
                while (true)
                {
                    c = getChar();
                    if (c == CHAR_EOF)
                    {
                        return (EOF);
                    };
                    if (c == CHAR_NL)
                    {
                        dirtyLine = false;
                        return (EOL);
                    };
                    if (!isJSSpace(c))
                    {
                        if (c != CHAR_DASH)
                        {
                            dirtyLine = true;
                        };
                        break;
                    };
                };
                if (c == CHAR_AT)
                {
                    return (XMLATTR);
                };
                isUnicodeEscapeStart = false;
                if (c == CHAR_BACKSLASH)
                {
                    c = getChar();
                    if (c == CHAR_u)
                    {
                        identifierStart = true;
                        isUnicodeEscapeStart = true;
                        stringBuffer.clear();
                    }
                    else
                    {
                        identifierStart = false;
                        ungetChar(c);
                        c = CHAR_BACKSLASH;
                    };
                }
                else
                {
                    identifierStart = isIdentifierStart(c);
                    if (identifierStart)
                    {
                        stringBuffer.clear();
                        addToString(c);
                    };
                };
                if (identifierStart)
                {
                    containsEscape = isUnicodeEscapeStart;
                    while (true)
                    {
                        if (isUnicodeEscapeStart)
                        {
                            escapeVal = 0;
                            i = 0;
                            while (i != 4)
                            {
                                c = getChar();
                                escapeVal = xDigitToInt(c, escapeVal);
                                if (escapeVal < 0) break;
                                i = (i + 1);
                            };
                            if (escapeVal < 0)
                            {
                                reportError("msg.invalid.escape");
                                return (ERROR);
                            };
                            addToString(escapeVal);
                            isUnicodeEscapeStart = false;
                        }
                        else
                        {
                            c = getChar();
                            if (c == CHAR_BACKSLASH)
                            {
                                c = getChar();
                                if (c == CHAR_u)
                                {
                                    isUnicodeEscapeStart = true;
                                    containsEscape = true;
                                }
                                else
                                {
                                    reportError("msg.illegal.character");
                                    return (ERROR);
                                };
                            }
                            else
                            {
                                if (((c == CHAR_EOF) || (!(isIdentifierPart(c))))) break;
                                addToString(c);
                            };
                        };
                    };
                    ungetChar(c);
                    str = getStringFromBuffer();
                    if (!containsEscape)
                    {
                        result = stringToKeyword(str);
                        if (result != EOF)
                        {
                            if (result != RESERVED)
                            {
                                return (result);
                            };
                            reportWarning("msg.reserved.keyword", str);
                        };
                    };
                    this.string = str;
                    return (NAME);
                };
                if (((isDigit(c)) || ((c == CHAR_DOT) && (isDigit(peekChar())))))
                {
                    stringBuffer.clear();
                    base = 10;
                    if (c == CHAR_0)
                    {
                        c = getChar();
                        if (((c == CHAR_x) || (c == CHAR_X)))
                        {
                            base = 16;
                            c = getChar();
                        }
                        else
                        {
                            if (isDigit(c))
                            {
                                base = 8;
                            }
                            else
                            {
                                addToString(CHAR_0);
                            };
                        };
                    };
                    if (base == 16)
                    {
                        while (0 <= xDigitToInt(c, 0))
                        {
                            addToString(c);
                            c = getChar();
                        };
                    }
                    else
                    {
                        while (((CHAR_0 <= c) && (c <= CHAR_9)))
                        {
                            if (((base == 8) && (c >= CHAR_8)))
                            {
                                reportWarning("msg.bad.octal.literal", ((c == CHAR_8) ? "8" : "9"));
                                base = 10;
                            };
                            addToString(c);
                            c = getChar();
                        };
                    };
                    isInteger = true;
                    if (((base == 10) && (((c == CHAR_DOT) || (c == CHAR_e)) || (c == CHAR_E))))
                    {
                        isInteger = false;
                        if (c == CHAR_DOT)
                        {
                            do 
                            {
                                addToString(c);
                                c = getChar();
                            } while (isDigit(c));
                        };
                        if (((c == CHAR_e) || (c == CHAR_E)))
                        {
                            addToString(c);
                            c = getChar();
                            if (((c == CHAR_PLUS) || (c == CHAR_DASH)))
                            {
                                addToString(c);
                                c = getChar();
                            };
                            if (!isDigit(c))
                            {
                                reportError("msg.missing.exponent");
                                return (ERROR);
                            };
                            do 
                            {
                                addToString(c);
                                c = getChar();
                            } while (isDigit(c));
                        };
                    };
                    ungetChar(c);
                    numString = getStringFromBuffer();
                    if (((base == 10) && (!(isInteger))))
                    {
                        try
                        {
                            dval = Number(numString);
                        }
                        catch(error:Error)
                        {
                            reportError("msg.caught.nfe");
                            return (ERROR);
                        };
                    }
                    else
                    {
                        dval = stringToNumber(numString, base);
                    };
                    this.number = dval;
                    return (NUMBER);
                };
                _loop_1:
                switch (c)
                {
                    case CHAR_DOUBLEQUOTE:
                    case CHAR_QUOTE:
                        return (readString(c));
                    case CHAR_SEMICOLON:
                        return (SEMI);
                    case CHAR_LBRACKET:
                        return (LB);
                    case CHAR_RBRACKET:
                        return (RB);
                    case CHAR_LBRACE:
                        return (LC);
                    case CHAR_RBRACE:
                        return (RC);
                    case CHAR_LPAREN:
                        return (LP);
                    case CHAR_RPAREN:
                        return (RP);
                    case CHAR_COMMA:
                        return (COMMA);
                    case CHAR_QUESTION:
                        return (HOOK);
                    case CHAR_TILDA:
                        return (BITNOT);
                    case CHAR_COLON:
                        return ((matchChar(CHAR_COLON)) ? COLONCOLON : COLON);
                    case CHAR_DOT:
                        if (matchChar(CHAR_DOT))
                        {
                            return (DOTDOT);
                        };
                        return ((matchChar(CHAR_LPAREN)) ? DOTQUERY : DOT);
                    case CHAR_PIPE:
                        if (matchChar(CHAR_PIPE))
                        {
                            return ((matchChar(CHAR_EQUAL)) ? ASSIGN_OR : OR);
                        };
                        return ((matchChar(CHAR_EQUAL)) ? ASSIGN_BITOR : BITOR);
                    case CHAR_CARET:
                        return ((matchChar(CHAR_EQUAL)) ? ASSIGN_BITXOR : BITXOR);
                    case CHAR_AMPERSAND:
                        if (matchChar(CHAR_AMPERSAND))
                        {
                            return ((matchChar(CHAR_EQUAL)) ? ASSIGN_AND : AND);
                        };
                        return ((matchChar(CHAR_EQUAL)) ? ASSIGN_BITAND : BITAND);
                    case CHAR_EQUAL:
                        if (matchChar(CHAR_EQUAL))
                        {
                            return ((matchChar(CHAR_EQUAL)) ? SHEQ : EQ);
                        };
                        return (ASSIGN);
                    case CHAR_BAN:
                        if (matchChar(CHAR_EQUAL))
                        {
                            return ((matchChar(CHAR_EQUAL)) ? SHNE : NE);
                        };
                        return (NOT);
                    case CHAR_LT:
                        if (matchChar(CHAR_BAN))
                        {
                            if (matchChar(CHAR_DASH))
                            {
                                if (matchChar(CHAR_DASH))
                                {
                                    skipLine();
                                    break;
                                };
                                ungetChar(CHAR_DASH);
                            };
                            ungetChar(CHAR_BAN);
                        };
                        if (matchChar(CHAR_LT))
                        {
                            return ((matchChar(CHAR_EQUAL)) ? ASSIGN_LSH : LSH);
                        }
                        else
                        {
                            return ((matchChar(CHAR_EQUAL)) ? LE : LT);
                        };
                    case CHAR_GT:
                        if (matchChar(CHAR_GT))
                        {
                            if (matchChar(CHAR_GT))
                            {
                                return ((matchChar(CHAR_EQUAL)) ? ASSIGN_URSH : URSH);
                            };
                            return ((matchChar(CHAR_EQUAL)) ? ASSIGN_RSH : RSH);
                        }
                        else
                        {
                            return ((matchChar(CHAR_EQUAL)) ? GE : GT);
                        };
                    case CHAR_STAR:
                        return ((matchChar(CHAR_EQUAL)) ? ASSIGN_MUL : MUL);
                    case CHAR_SLASH:
                        if (matchChar(CHAR_SLASH))
                        {
                            skipLine();
                            break;
                        };
                        if (matchChar(CHAR_STAR))
                        {
                            lookForSlash = false;
                            while (true)
                            {
                                c = getChar();
                                if (c == CHAR_EOF)
                                {
                                    reportError("msg.unterminated.comment");
                                    return (ERROR);
                                };
                                if (c == CHAR_STAR)
                                {
                                    lookForSlash = true;
                                }
                                else
                                {
                                    if (c == CHAR_SLASH)
                                    {
                                        if (lookForSlash) break _loop_1;
                                    }
                                    else
                                    {
                                        lookForSlash = false;
                                    };
                                };
                            };
                        };
                        return ((matchChar(CHAR_EQUAL)) ? ASSIGN_DIV : DIV);
                    case CHAR_PERCENT:
                        return ((matchChar(CHAR_EQUAL)) ? ASSIGN_MOD : MOD);
                    case CHAR_PLUS:
                        if (matchChar(CHAR_EQUAL))
                        {
                            return (ASSIGN_ADD);
                        };
                        return ((matchChar(CHAR_PLUS)) ? INC : ADD);
                    case CHAR_DASH:
                        if (matchChar(CHAR_EQUAL))
                        {
                            c = ASSIGN_SUB;
                        }
                        else
                        {
                            if (matchChar(CHAR_DASH))
                            {
                                if (!dirtyLine)
                                {
                                    if (matchChar(CHAR_GT))
                                    {
                                        skipLine();
                                        break;
                                    };
                                };
                                c = DEC;
                            }
                            else
                            {
                                c = SUB;
                            };
                        };
                        dirtyLine = true;
                        return (c);
                    default:
                        reportError("msg.illegal.character");
                        return (ERROR);
                };
            };
            return (0); //dead code
        }

        private function readString(_arg_1:int):int
        {
            var _local_2:int;
            var _local_4:int;
            var _local_5:String;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            stringBuffer.clear();
            var _local_3:int = getChar();
            _loop_1:
            while (_local_3 != _arg_1)
            {
                if (((_local_3 == CHAR_NL) || (_local_3 == CHAR_EOF)))
                {
                    ungetChar(_local_3);
                    reportError("msg.unterminated.string.lit");
                    return (ERROR);
                };
                if (_local_3 == CHAR_BACKSLASH)
                {
                    _local_3 = getChar();
                    switch (_local_3)
                    {
                        case CHAR_b:
                            _local_3 = CHAR_BACKSLASH;
                            break;
                        case CHAR_f:
                            _local_3 = CHAR_FEED;
                            break;
                        case CHAR_n:
                            _local_3 = CHAR_NL;
                            break;
                        case CHAR_r:
                            _local_3 = CHAR_CR;
                            break;
                        case CHAR_t:
                            _local_3 = CHAR_TAB;
                            break;
                        case CHAR_v:
                            _local_3 = 11;
                            break;
                        case CHAR_u:
                            _local_4 = stringBuffer.length;
                            _local_5 = "u";
                            _local_2 = 0;
                            _local_6 = 0;
                            while (_local_6 != 4)
                            {
                                _local_3 = getChar();
                                _local_2 = xDigitToInt(_local_3, _local_2);
                                if (_local_2 < 0)
                                {
                                    addToString(_local_5);
                                    continue _loop_1;
                                };
                                _local_5 = (_local_5 + String.fromCharCode(_local_3));
                                _local_6++;
                            };
                            _local_3 = _local_2;
                            break;
                        case CHAR_x:
                            _local_3 = getChar();
                            _local_2 = xDigitToInt(_local_3, 0);
                            if (_local_2 < 0)
                            {
                                addToString(CHAR_x);
                                continue _loop_1;
                            };
                            _local_7 = _local_3;
                            _local_3 = getChar();
                            _local_2 = xDigitToInt(_local_3, _local_2);
                            if (_local_2 < 0)
                            {
                                addToString(CHAR_x);
                                addToString(_local_7);
                                continue _loop_1;
                            };
                            _local_3 = _local_2;
                            break;
                        case CHAR_NL:
                            _local_3 = getChar();
                            continue _loop_1;
                        default:
                            if (((CHAR_0 <= _local_3) && (_local_3 < CHAR_8)))
                            {
                                _local_8 = (_local_3 - CHAR_0);
                                _local_3 = getChar();
                                if (((CHAR_0 <= _local_3) && (_local_3 < CHAR_8)))
                                {
                                    _local_8 = (((8 * _local_8) + _local_3) - CHAR_0);
                                    _local_3 = getChar();
                                    if ((((CHAR_0 <= _local_3) && (_local_3 < CHAR_8)) && (_local_8 <= 37)))
                                    {
                                        _local_8 = (((8 * _local_8) + _local_3) - CHAR_0);
                                        _local_3 = getChar();
                                    };
                                };
                                ungetChar(_local_3);
                                _local_3 = _local_8;
                            };
                    };
                };
                addToString(_local_3);
                _local_3 = getChar();
            };
            this.string = getStringFromBuffer();
            return (STRING);
        }

        private function readQuotedString(_arg_1:int):Boolean
        {
            var _local_2:int = getChar();
            while (_local_2 != CHAR_EOF)
            {
                addToString(_local_2);
                if (_local_2 == _arg_1)
                {
                    return (true);
                };
                _local_2 = getChar();
            };
            stringBuffer.clear();
            this.string = null;
            reportError("msg.XML.bad.form");
            return (false);
        }

        private function stringToNumber(_arg_1:String, _arg_2:Number):Number
        {
            var _local_4:int;
            var _local_3:Number = 0;
            if (_arg_2 == 10)
            {
                return (Number(_arg_1));
            };
            if (_arg_2 == 16)
            {
                _local_4 = 0;
                while (_local_4 < _arg_1.length)
                {
                    _local_3 = xDigitToInt(_arg_1.charCodeAt(_local_4), _local_3);
                    _local_4++;
                };
            }
            else
            {
                if (_arg_2 == 8)
                {
                    _local_4 = 0;
                    while (_local_4 < _arg_1.length)
                    {
                        _local_3 = oDigitToInt(_arg_1.charCodeAt(_local_4), _local_3);
                        _local_4++;
                    };
                }
                else
                {
                    Env.reportError("msg.bad.number.base", _arg_2);
                };
            };
            return (_local_3);
        }

        public function peekChar():int
        {
            var _local_1:int = getChar();
            ungetChar(_local_1);
            return (_local_1);
        }

        public function getChar():int
        {
            var _local_1:int;
            if (ungetCursor != 0)
            {
                return (ungetBuffer[--ungetCursor]);
            };
            while (true)
            {
                if (sourceCursor == sourceEnd)
                {
                    hitEOF = true;
                    return (CHAR_EOF);
                };
                _local_1 = sourceString.charCodeAt(sourceCursor++);
                if (lineEndChar >= 0)
                {
                    if (((lineEndChar == CHAR_CR) && (_local_1 == CHAR_NL)))
                    {
                        lineEndChar = CHAR_NL;
                        continue;
                    };
                    lineEndChar = -1;
                    lineStart = (sourceCursor - 1);
                    lineno++;
                };
                if (_local_1 <= 127)
                {
                    if (((_local_1 == CHAR_NL) || (_local_1 == CHAR_CR)))
                    {
                        lineEndChar = _local_1;
                        _local_1 = CHAR_NL;
                    };
                }
                else
                {
                    if (isJSLineTerminator(_local_1))
                    {
                        lineEndChar = _local_1;
                        _local_1 = CHAR_NL;
                    };
                };
                return (_local_1);
            };
            return (0); //dead code
        }

        public function getStringFromBuffer():String
        {
            return (stringBuffer.toString());
        }

        final public function getLine():String
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            if (sourceString != null)
            {
                _local_1 = sourceCursor;
                if (lineEndChar >= 0)
                {
                    _local_1--;
                }
                else
                {
                    while (_local_1 != sourceEnd)
                    {
                        _local_2 = sourceString.charCodeAt(_local_1);
                        if (isJSLineTerminator(_local_2)) break;
                        _local_1++;
                    };
                };
                return (sourceString.substring(lineStart, _local_1));
            };
            _local_3 = (sourceCursor - lineStart);
            if (lineEndChar >= 0)
            {
                _local_3--;
            }
            else
            {
                while (true)
                {
                    _local_4 = (lineStart + _local_3);
                    if (_local_4 == sourceEnd) break;
                    _local_2 = sourceString.charCodeAt(_local_4);
                    if (isJSLineTerminator(_local_2)) break;
                    _local_3++;
                };
            };
            return (sourceString.substring(lineStart, _local_3));
        }

        final public function eof():Boolean
        {
            return (hitEOF);
        }

        private function readXmlComment():Boolean
        {
            var _local_1:int = getChar();
            while (_local_1 != CHAR_EOF)
            {
                addToString(_local_1);
                if (((_local_1 == CHAR_DASH) && (peekChar() == CHAR_DASH)))
                {
                    _local_1 = getChar();
                    addToString(_local_1);
                    if (peekChar() == CHAR_GT)
                    {
                        _local_1 = getChar();
                        addToString(_local_1);
                        return (true);
                    };
                }
                else
                {
                    _local_1 = getChar();
                };
            };
            stringBuffer.clear();
            this.string = null;
            reportError("msg.XML.bad.form");
            return (false);
        }


    }
}//package r1.deval.parser

