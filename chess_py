def location2index(loc: str) -> tuple[int, int]:
    '''converts chess location to corresponding x and y coordinates'''
    l1=list(loc)
    int1=(ord(l1[0])-96)
    int2=int(''.join(l1[1:]))
    t=(int1,int2)
    return t
    
    
def index2location(x: int, y: int) -> str:
    '''converts  pair of coordinates to corresponding location'''
    str1=chr(x+96)
    str2=str(y)
    str3=str1+str2
    return str3


class Piece:
    pos_x : int	
    pos_y : int
    side : bool #True for White and False for Black
    def __init__(self, pos_X : int, pos_Y : int, side_ : bool):
        '''sets initial values'''
        self.pos_x=pos_X
        self.pos_y=pos_Y
        self.side=side_

Board = tuple[int, list[Piece]]

def is_piece_at(pos_X : int, pos_Y : int, B: Board) -> bool:
    '''checks if there is piece at coordinates pox_X, pos_Y of board B''' 
    Board1 : list[Piece]
    Board1=B[1]
    finished=False
    while not finished:
        for P in Board1:
            if P.pos_x == pos_X and P.pos_y == pos_Y:
                finished = True
                return True
        if not finished:
            return False
          	
def piece_at(pos_X : int, pos_Y : int, B: Board) -> Piece:
    # returns the piece at coordinates pox_X, pos_Y of board B 
    # assumes some piece at coordinates pox_X, pos_Y of board B is present
    for i in B[1]:
        if i.pos_x == pos_X and i.pos_y==pos_Y:
            return i
            break



class Knight(Piece):
    def __init__(self, pos_X : int, pos_Y : int, side_ : bool):
        #sets initial values by calling the constructor of Piece
        super().__init__(pos_X,pos_Y,side_)
       
    def can_reach(self, pos_X : int, pos_Y : int, B: Board) -> bool:
        # checks if this rook can move to coordinates pos_X, pos_Y on board B according to rule [Rule1] and [Rule3]
        # Hint: use is_piece_at
        s:int
        s=B[0]
        if 1<=pos_X<=s and 1<=pos_Y<=s:
            if is_piece_at(pos_X,pos_Y,B) and piece_at(pos_X,pos_Y,B).side == self.side:   
                return False
            elif abs(self.pos_x-pos_X)==1 and abs(self.pos_y-pos_Y)==2:
                return True
            elif abs(self.pos_x-pos_X)==2 and abs(self.pos_y-pos_Y)==1:
                return True
            else:
                return False
        else:
            return False

        
    def can_move_to(self, pos_X : int, pos_Y : int, B: Board) -> bool:
        # checks if this rook can move to coordinates pos_X, pos_Y on board B according to all chess rules
        # - firstly, check [Rule1] and [Rule3] using can_reach.
        # - secondly, check if result of move is capture using is_piece_at
        # - if yes, find the piece captured using piece_at
        # - thirdly, construct new board resulting from move
        # - finally, to check [Rule4], use is_check on new board
        import copy
        B1=copy.deepcopy(B)
        if self.can_reach(pos_X, pos_Y, B1):
            if is_piece_at(pos_X,pos_Y,B1):
                p=piece_at(pos_X,pos_Y,B1)
                B1[1].remove(p)
            self_copy = piece_at(self.pos_x, self.pos_y, B1)
            B1[1].remove(self_copy)
            B1[1].append(Knight(pos_X,pos_Y,self.side))
            return is_check(self.side,B1)==False
        else:
            return False



    def move_to(self, pos_X : int, pos_Y : int, B: Board) -> Board:
        # returns new board resulting from move of this rook to coordinates pos_X, pos_Y on board B 
        # assumes this move is valid according to chess rules
        import copy
        B1=copy.deepcopy(B)
        self_copy = piece_at(self.pos_x, self.pos_y, B1)
        B1[1].remove(self_copy)
        if is_piece_at(pos_X,pos_Y,B1) == True:
            p=piece_at(pos_X,pos_Y,B1)
            B1[1].remove(p)
        B1[1].append(Knight(pos_X,pos_Y,self.side))
        return B1



class King(Piece):
    def __init__(self, pos_X : int, pos_Y : int, side_ : bool):
        #sets initial values by calling the constructor of Piece
        super().__init__(pos_X,pos_Y,side_)

    def can_reach(self, pos_X : int, pos_Y : int, B: Board) -> bool:
        #checks if this king can move to coordinates pos_X, pos_Y on board B according to rule [Rule2] and [Rule3]
        s:int
        s=B[0]
        if 1<=pos_X<=s and 1<=pos_Y<=s:
            if is_piece_at(pos_X,pos_Y,B) and piece_at(pos_X,pos_Y,B).side == self.side: 
                return False
            elif abs(self.pos_x-pos_X)==abs(self.pos_y-pos_Y)==1:
                return True
            elif abs(self.pos_x-pos_X)==1 and self.pos_y==pos_Y:
                return True
            elif self.pos_x==pos_X and abs(self.pos_y-pos_Y)==1:
                return True
            else:
                return False
        else:
            return False

    def can_move_to(self, pos_X : int, pos_Y : int, B: Board) -> bool:
        #checks if this king can move to coordinates pos_X, pos_Y on board B according to all chess rules
        import copy
        B1=copy.deepcopy(B)
        if self.can_reach(pos_X, pos_Y, B1):
            if is_piece_at(pos_X,pos_Y,B1):
                p=piece_at(pos_X,pos_Y,B1)
                B1[1].remove(p)
            self_copy = piece_at(self.pos_x, self.pos_y, B1)
            B1[1].remove(self_copy)
            B1[1].append(King(pos_X,pos_Y,self.side))
            return is_check(self.side,B1)==False
        else:
            return False


    def move_to(self, pos_X : int, pos_Y : int, B: Board) -> Board:
        # returns new board resulting from move of this king to coordinates pos_X, pos_Y on board B 
        # assumes this move is valid according to chess rules
        import copy
        B1=copy.deepcopy(B)
        self_copy = piece_at(self.pos_x, self.pos_y, B1)
        B1[1].remove(self_copy)
        if is_piece_at(pos_X,pos_Y,B1) == True:
            p=piece_at(pos_X,pos_Y,B1)
            B1[1].remove(p)
        B1[1].append(King(pos_X,pos_Y,self.side))
        return B1



def is_check(side: bool, B: Board) -> bool:
    P: Piece
    x:int
    y:int  
    for P in B[1]:#find the king of this side
        if P.__class__.__name__ == "King" and P.side == side:
                x_king = P.pos_x
                y_king = P.pos_y
    finished= False
    while not finished:
        for P in B[1]:#find if any piece can reach to the king
            if P.can_reach(x_king,y_king,B):
                finished=True
                return True
        if not finished:
            return False



def is_checkmate(side: bool, B: Board) -> bool:
    # checks if configuration of B is checkmate for side
    P: Piece
    x:int
    y:int
    for P in B[1]:#find the king of this side
        if P.__class__.__name__ == "King" and P.side == side:
            x = P.pos_x
            y = P.pos_y
    if is_check(side,B):#find out whether is check or not        
        finished= False
        while not finished:
            for i in ((x-1),x,(x+1)):
                for j in ((y-1),y,(y+1)):#find if there is no move avaliable for king
                    if King(x,y,side).can_move_to(i,j,B)==True:
                        finished=True
                        return False
            if not finished:
                return True
    else:
        return False
        
                
def is_stalemate(side: bool, B: Board) -> bool:
    # checks if configuration of B is stalemate for side
    # - use is_check
    # - use can_move_to
    P: Piece
    x:int
    y:int
    for P in B[1]:
        if P.__class__.__name__ == "King" and P.side == side:
            x = P.pos_x
            y = P.pos_y
    if is_check(side,B)==False:#find if it is not check
        finished= False
        while not finished:
            for i in ((x-1),x,(x+1)):
                for j in ((y-1),y,(y+1)):#find if there is no move avaliable for king
                    if King(x,y,side).can_move_to(i,j,B)==True:
                        finished=True
                        return False
            if not finished:
                return True
    else:
        return False

        


def read_board(filename: str) -> Board:
    # reads board configuration from file in current directory in plain format
    # raises IOError exception if file is not valid (see section Plain board configurations)
    infile=open(filename,'r')
    a=[]
    for line in infile:
        if line != '':
            a.append(line.rstrip())
    if len(a)!= 3:#check this file is vaild or not
        return None
    s=int(a[0])  #first line is the size of the board 
    list1:list[Piece]=[]#collect all the pieces
    list2:list[list[int]]=[]#use list 2 check if there are two pieces in the same location
    w=a[1].split(', ')#the second line is the white side
    b=a[2].split(', ')#the third line is the black side
    infile.close()

    count=0#check if only one king in the white side
    for i in w:#separate the king and knight of the white side,append to the list1
        if i[0]=='N':
            m=i[1:]
            n=location2index(m)
            x=n[0]
            y=n[1]
            if x>s or y>s:#check each location is within the S x S square
                return None
            list1.append(Knight(x,y,True))
            list2.append([x,y])
        if i[0]=='K':
            m=i[1:]
            n=location2index(m)
            x=n[0]
            y=n[1]
            if x>s or y>s:#check each location is within the S x S square
                return None
            list1.append(King(x,y,True))
            list2.append([x,y])
            count += 1
            if count > 1:
                return None#check if only one king in the white side
    
    count=0#check if only one king in the black side
    for i in b:#separate the king and knight of the black side,,append to the list1
        if i[0]=='N':
            m=i[1:]
            n=location2index(m)
            x=n[0]
            y=n[1]
            if x>s or y>s:#check each location is within the S x S square
                return None
            list1.append(Knight(x,y,False))
            list2.append([x,y])
        if i[0]=='K':
            m=i[1:]
            n=location2index(m)
            x=n[0]
            y=n[1]
            if x>s or y>s:#check each location is within the S x S square
                return None
            list1.append(King(x,y,False))
            list2.append([x,y])
            count += 1
            if count > 1:
                return None#check if only one king in the black side
    seen=[]
    dupes=[]
    for x in list2:
        if x in seen:
            dupes.append(x)
        else:
            seen.append(x)
    if dupes!=[]:#use list 2:list[list[x,y]] check if there are two pieces in the same location
        return None    
    Board1 = (s,list1)
    return Board1



def save_board(filename: str, B: Board) -> None:
    # saves board configuration into file in current directory in plain format
    outfile=open(filename,'w')
    s=str(B[0])
    outfile.write(s+'\n')#size of Board
    line1=[]#collect all white pieces
    line2=[]#collect all black pieces
    P:Piece
    for P in B[1]:#convert all pieces to unicode str into this list of lists
        if P.__class__.__name__ == "King" and P.side == True:
            x = P.pos_x
            y = P.pos_y
            line1.append('K'+ index2location(x, y))
        elif P.__class__.__name__ == "Knight" and P.side == True:
            x = P.pos_x
            y = P.pos_y
            line1.append('N'+ index2location(x, y))
        elif P.__class__.__name__ == "King" and P.side == False:
            x = P.pos_x
            y = P.pos_y
            line2.append('K'+ index2location(x, y))
        elif P.__class__.__name__ == "Knight" and P.side == False:
            x = P.pos_x
            y = P.pos_y
            line2.append('N'+ index2location(x, y))
    line1_str=', '.join(line1)+'\n'
    line2_str=', '.join(line2)+'\n'
    outfile.write(line1_str)
    outfile.write(line2_str)
    outfile.close()



def find_black_move(B: Board) -> tuple[Piece, int, int]:
    # returns (P, x, y) where a Black piece P can move on B to coordinates x,y according to chess rules 
    # assumes there is at least one black piece that can move somewhere
    # - use methods of random library
    # - use can_move_to
    import random
    s=B[0]#size of Board
    P:Piece
    BL:list[Piece]=[]
    for P in B[1]:
        if P.side == False:
            BL.append(P)#put all black pieces into a new list
    finished=False
    while not finished:
        x=random.randint(1,s)
        y=random.randint(1,s)
        for P in BL:#random pick x,y and find a black piece that can move to the location
            if P.can_move_to(x,y,B):
                finished=True
                black_move=(P,x,y)
                return black_move



def conf2unicode(B: Board) -> str: 
    #converts board cofiguration B to unicode format string (see section Unicode board configurations)
    wk='\u2654'#white king
    wn='\u2658'#white knight
    bk='\u265A'#black king
    bn='\u265E'#black knight
    blank='\u2001'#blank space
    s=B[0]#size of Board
    c = [[None for x in range(0,s)] for y in range(0,s) ]#plain board examp
    P:Piece
    for P in B[1]:#convert all pieces to unicode str into this list of lists
        if P.__class__.__name__ == "King" and P.side == True:
            x = P.pos_x
            y = P.pos_y
            i=abs(y-s)
            j=x-1
            c[i][j]=wk
        elif P.__class__.__name__ == "Knight" and P.side == True:
            x = P.pos_x
            y = P.pos_y
            i=abs(y-s)
            j=x-1
            c[i][j]=wn
        elif P.__class__.__name__ == "King" and P.side == False:
            x = P.pos_x
            y = P.pos_y
            i=abs(y-s)
            j=x-1
            c[i][j]=bk
        elif P.__class__.__name__ == "Knight" and P.side == False:
            x = P.pos_x
            y = P.pos_y
            i=abs(y-s)
            j=x-1
            c[i][j]=bn
    for i in range(0,s):#fill up the rest parts with blank'\u2001' 
        for j in range(0,s):
            if c[i][j]== None:
                c[i][j]=blank
    #transfer the list above to a whole str
    unicode_str=''
    for i in range(0,s):
        if i <s-1:
            temp = (''.join(c[i]))+'\n'
            unicode_str = unicode_str + temp
        else:
            temp = (''.join(c[i]))
            unicode_str = unicode_str + temp
    return unicode_str



def main() -> None:
    # initiation
    import string
    filename = input("File name for initial configuration: ")
    finished=False
    while not finished:
        if filename != 'QUIT':
            if read_board(filename)!= None:
                B = read_board(filename)
                print('The initial configuration is:\n'+conf2unicode(B))
                finished=True
            else:
                filename = input('This is not a valid file. File name for initial configuration: ')
        else:
            finished=True
            quit()
    #Play rounds
    white_move=input('Next move of White: ')#for player input vaild white move or quit
    finished=False
    while not finished:
        if white_move == 'QUIT':
            filename=input('File name to store the configuration: ')
            save_board(filename, B)
            print('The game configuration saved.')
            finished=True
            quit()
        else:#devide the string white_move to into two strings
            alphabet = list(string.ascii_lowercase)
            lwm=list(white_move)
            for i in range(1,len(lwm)):
                if lwm[i] in alphabet:
                    string1=''.join(lwm[:i])#original location
                    string2=''.join(lwm[i:])#destination 
                    break
            loc_1=location2index(string1)#transfer to tuple[int, int]
            loc_2=location2index(string2)
            x1=loc_1[0]
            y1=loc_1[1]
            x2=loc_2[0]
            y2=loc_2[1]
            if is_piece_at(x1,y1,B) and piece_at(x1,y1,B).can_move_to(x2,y2,B):#check if it is a vaild move
                B=piece_at(x1,y1,B).move_to(x2,y2,B)#update board after white move
                if is_checkmate(False, B):
                    print('Game over. White wins.')
                    finished=True
                if is_stalemate(False, B):
                    print('Game over. Stalemate.')
                    finished=True
                else:#print new board and jump to next step:black move
                    print("The configuration after White's move is:\n" + conf2unicode(B))
                    #for computer output next black move            
                    b_move=find_black_move(B)#tuple[Piece, int, int]
                    the_piece:Piece
                    the_piece=b_move[0]
                    x1=the_piece.pos_x#the original location
                    y1=the_piece.pos_y
                    x2=b_move[1]#destination
                    y2=b_move[2]
                    mov_str=index2location(x1, y1)+index2location(x2, y2)
                    B=the_piece.move_to(x2,y2,B)#update board after black move
                    if is_checkmate(True, B):
                        print('Game over. Black wins.')
                        finished=True
                    if is_stalemate(True, B):
                        print('Game over. Stalemate.')
                        finished=True
                    else:#print updated board and jump to the start of this while loop:white_move
                        print("Next move of Black is "+ mov_str+'.'+" The configuration after Black's move is:\n"+conf2unicode(B))
                        white_move=input('Next move of White: ')
            else:#loop until player input vaild white move or quit 
                white_move=input('This is not a valid move. Next move of White: ')

        
if __name__ == '__main__': #keep this in
   main()

