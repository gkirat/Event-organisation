// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract eventorganization{
    address payable public owner=payable(msg.sender);

    
    struct Eventdetails{
        address payable  by;
        string name;
        uint eventid;
        uint date;
        uint priceofticket;
        uint remainingtickets;
        bool housefull;
    }
    struct Info{
        uint eid;
        address payable ownerticadd;
        uint price;
        uint availabletic;     
    }
    Info[] blacktic;


    mapping(uint=>Eventdetails)public Events ;
    uint public numberofevents=1;

    mapping(address=>mapping(uint=>uint)) public Tickets;

   


        function Createevent(string memory _name,uint _date,uint _priceofticket,uint _totaltickets)public payable {
            require(_date>=block.timestamp+1000,"Event can be conducted atleast an hour after the event registration");
            require(_priceofticket>0 ,"Ticket price should be grater than zero");
            require(_totaltickets>0,"tickets should be greater than zero");
            require(msg.value==10000,"Please pay 10000 wei ");
            owner.transfer(msg.value);
            
            
            Events[numberofevents]=Eventdetails(payable(msg.sender),_name,numberofevents,_date,_priceofticket,_totaltickets,false);
            numberofevents++;
        }

        function Buytickets(uint Idofevent,uint quantity)external payable{
            require(Idofevent>0,"Event id starts from 1");
            require(quantity>0,"Minimum ticket quantity should be more than zero");
            require(Events[Idofevent].date>block.timestamp,"Event has already occured");
            require(msg.sender!=Events[Idofevent].by,"Owner can't buy thier own ticket");
            
            
            Eventdetails storage _event=Events[Idofevent];
            require(Events[Idofevent].housefull!=true,"All tickets sold");
            require(msg.value==Events[Idofevent].priceofticket*quantity*10**18,"PLease pay the exact price");
            require(Events[Idofevent].remainingtickets>=quantity,"Not enough tickets");
            Tickets[msg.sender][Idofevent]+=quantity;
            Events[Idofevent].remainingtickets-=quantity;
            if(Events[Idofevent].remainingtickets==0){
                Events[Idofevent].housefull=true;
            }
             Events[Idofevent].by.transfer(msg.value);
        }

        function Transfertickets(uint eventid,uint quantity,address to) external {
            require(Tickets[msg.sender][eventid]>=quantity,"You don't have enough tickets to transfer");
            require(Events[eventid].date>block.timestamp,"The event has already occured");

            Tickets[msg.sender][eventid]-=quantity;
            Tickets[to][eventid]+=quantity;
        }

        function ResellTic(uint resellprice,uint idOfEvent,uint noOfTickets)public payable {
            require(Events[idOfEvent].remainingtickets==0,"Tickets still reamaining ");
            require(resellprice<=2*Events[idOfEvent].priceofticket,"Price can't exceed twice the original price");
            require(noOfTickets<=Tickets[msg.sender][idOfEvent],"You don't have that many tickets");
            require(noOfTickets<=2,"Not more than 2 tickets can be resold per address");
            require(block.timestamp<Events[idOfEvent].date,"Event is over");


          
            Info memory details;
            details.eid=idOfEvent;
            details.ownerticadd=payable(msg.sender);
            details.price=resellprice*10**18;
            details.availabletic=noOfTickets;
            
            blacktic.push(details);

            
            
        }




        function ResellTicInfo(uint eventid)public view returns(Info memory){
           
            for(uint i=0;i<blacktic.length;i++){
                for(uint x=0;i<blacktic.length;x++){
                    if(eventid==blacktic[i].eid ){
                        return blacktic[i];
                    }
                }
            }
        }

        function BuyresellTic(uint eventid,uint _nooftic,address from)public  payable {
        
            for(uint i=0;i<blacktic.length;i++){
                if(eventid==blacktic[i].eid ){
                    for(uint x=0;x<blacktic.length;x++){
                            if(from==blacktic[x].ownerticadd && msg.sender!=blacktic[x].ownerticadd && i==x){
                            require(eventid==blacktic[x].eid && from==blacktic[x].ownerticadd && msg.sender!=blacktic[x].ownerticadd,"Details should match" );
                            require(msg.value==blacktic[x].price*_nooftic,"Please pay the exact price");
                            blacktic[i].ownerticadd.transfer(((msg.value)*95)/100);
                            Events[eventid].by.transfer(((msg.value)*5)/100);
                            blacktic[i].availabletic-=_nooftic;
                            Tickets[from][eventid]-=_nooftic;
                            Tickets[msg.sender][eventid]+=_nooftic;
                            if(blacktic[i].availabletic==0){

                                delete blacktic[i];           
                            }
                        }
                    }
                }    
            }
        
        }
}


// 1661248000

    
// && from==blacktic[i].ownerticadd && msg.sender!=blacktic[i].ownerticadd
    


// 1661245746

//  ticOwners memory tempdetails;
//             tempdetails.eventname=Events[idOfEvent].name;
//             Basicinfo memory details;
//             details.ticOwnerAdd=msg.sender;
//             details.numOfreselltic=noOfTickets;
//             details.price=resellprice;
//             blacktic[idOfEvent].ticinfo.push(details);
            // blacktic.push(tempdetails);









 // Basicinfo memory details;
// details.ticOwnerAdd=payable(msg.sender);
// details.numOfreselltic=noOfTickets;
// details.price=resellprice;
// // blacktic[idOfEvent].ticinfo.push(details);
            
// tempdetails.eventname=Events[idOfEvent].name;
// tempdetails.ticinfo.push(details);
// ticOwners storage tempdetails=blacktic[idOfEvent];
// tempdetails.eventname=Events[idOfEvent].name;
// blacktic.push(tempdetails);

// tempdetails.
// blacktic[idOfEvent]




//   Basicinfo storage tempdetails = blacktic[idOfEvent];
//             uint x;
//             while(x>=0){
//                 tempdetails.ticOwnerAdd[x]=msg.sender;
//                 tempdetails.numOfreselltic[x]=noOfTickets;
//                 tempdetails.price[x]=resellprice;
               
//                 x++;   
//             }
            


    //          struct Basicinfo{
    //     // address[]   ticOwnerAdd;
    //     // uint[] numOfreselltic;
    //     uint[] price;
    // }
    // // struct ticOwners{
    // //     string eventname;
    // //     Basicinfo[] ticinfo;
        
    // // }
    // mapping(uint=>Basicinfo)  blacktic;
    // // Basicinfo[] blacktic;






                        // Info memory details;
                        // details.eid=0;
                        // details.ownerticadd=payable(0);
                        // details.price=0;
                        // details.nooftic=noOfTickets;
            
                        // blacktic.push(details);    





//  if(eventid==blacktic[i].eid && from==blacktic[i].ownerticadd && msg.sender!=blacktic[i].ownerticadd ){
//                     require(eventid==blacktic[i].eid && from==blacktic[i].ownerticadd && msg.sender!=blacktic[i].ownerticadd,"Details should match" );
//                     require(msg.value==blacktic[i].price*_nooftic,"Please pay the exact price");
//                     blacktic[i].ownerticadd.transfer(((msg.value)*95)/100);
//                     Events[eventid].by.transfer(((msg.value)*5)/100);
//                     blacktic[i].availabletic-=_nooftic;
//                     Tickets[from][eventid]-=_nooftic;
//                     Tickets[msg.sender][eventid]+=_nooftic;
//                     if(blacktic[i].availabletic==0){
//                         delete blacktic[i];           
//                     }
//                 }




//  int swapped=0;
//             for(uint i=0;i<blacktic.length;i++){
//                 for(uint x=0;i<blacktic.length;x++){
//                     if(blacktic[i].eid==blacktic[x].eid && x!=i && i<x && blacktic[i].price > blacktic[x].price){
//                         Info memory temp;
//                         temp=blacktic[i];
//                         blacktic[i]=blacktic[x];
//                         blacktic[x]=temp;
//                         swapped=1;
//                     }

//                     if(swapped==0){
//                         break;
//                     }
//                 }
// }
