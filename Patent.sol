pragma solidity ^0.4.25;

contract Patent
{
    enum StateType { Active, PatentApplied, PendingInspection, Inspected, SubtantiveExamined, NotionalAcceptance, Accepted, Terminated }
    
    address public Admin;
    
    address public Applicant; //added
    string public Description; //added
    uint public Askingclaims; //added
    
    uint public Corrections; //added
    string public CorrectionDetails; //added
        
    StateType public State; //added

    // address public InstanceBuyer;
    // uint public Offerclaims;
    address public InstanceInspector; //added
    address public InstanceAppraiser; //added
    

    constructor(string description, uint256 claims) public
    {
        Applicant = msg.sender;
        Askingclaims = claims;
        Description = description;
        State = StateType.Active;
    }

    function Terminate() public
    {
        if (Applicant != msg.sender)
        {
            revert();
        }

        State = StateType.Terminated;
    }

    // Modifications after first round of inspection
    function Modify(string description, uint256 claims) public
    {
        if (State != StateType.Active)
        {
            revert();
        }
        if (Applicant != msg.sender)
        {
            revert();
        }

        Description = description;
        Askingclaims = claims;
    }

// offer made by buyer... so here, examiner takes up the patent for examination 
    function StartExamination (address inspector, address appraiser) public
    {
        if (inspector == 0x0 || appraiser == 0x0)
        {
            revert();
        }
        if (State != StateType.Active)
        {
            revert();
        }
        // Cannot enforce "AllowedRoles":["Buyer"] because Role information is unavailable
        if (Applicant == msg.sender) // not expressible in the current specification language
        {
            revert();
        }

        // InstanceBuyer = msg.sender;
        InstanceInspector = inspector;
        InstanceAppraiser = appraiser;
        // Offerclaims = offerclaims;
        State = StateType.PatentApplied;
    }

    function AcceptOffer() public
    {
        if (State != StateType.PatentApplied)
        {
            revert();
        }

        State = StateType.PendingInspection;
    }

    function Reject() public
    {
        if (State != StateType.PatentApplied && State != StateType.PendingInspection && State != StateType.Inspected && State != StateType.SubtantiveExamined
&& State != StateType.NotionalAcceptance)
        {
            revert();
        }
        if (Applicant != msg.sender)
        {
            revert();
        }

        // InstanceBuyer = 0x0;
        State = StateType.Active;
    }

    function Accept() public
    {
        if (msg.sender != Admin)
        {
            revert();
        }

        if (msg.sender == Admin &&
            State != StateType.NotionalAcceptance)
        {
            revert();
        }


        if (msg.sender == Admin)
        {
            if (State == StateType.NotionalAcceptance)
            {
                State = StateType.Accepted;
            }
        }
    }

    
    // Suggest changes

    function RescindOffer(uint corrections, string details) public
    {
        if (State != StateType.PatentApplied && State != StateType.PendingInspection && State != StateType.Inspected && State != StateType.SubtantiveExamined
&& State != StateType.NotionalAcceptance)
        {
            revert();
        }
        if (Admin != msg.sender && InstanceInspector != msg.sender && InstanceAppraiser != msg.sender)
        {
            revert();
        }

        // InstanceBuyer = 0x0;
        // Offerclaims = 0;
        Corrections = corrections;
        CorrectionDetails = details;
        State = StateType.Active;
    }
    
    // second examination

    function MarkSubtantiveExamined() public
    {
        if (InstanceAppraiser != msg.sender)
        {
            revert();
        }

        if (State == StateType.PendingInspection)
        {
            State = StateType.SubtantiveExamined;
        }
        else if (State == StateType.Inspected)
        {
            // Both examination completed
            State = StateType.NotionalAcceptance;
        }
        else
        {
            revert();
        }
    }

    // first examination
    function MarkInspected() public
    {
        if (InstanceInspector != msg.sender)
        {
            revert();
        }

        if (State == StateType.PendingInspection)
        {
            State = StateType.Inspected;
        }
        else if (State == StateType.SubtantiveExamined)
        {
            State = StateType.NotionalAcceptance;
        }
        else
        {
            revert();
        }
    }
}
