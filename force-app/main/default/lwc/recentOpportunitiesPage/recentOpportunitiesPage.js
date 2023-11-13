import { LightningElement,track,wire} from 'lwc';
import getRecentOpportunities from '@salesforce/apex/opportunityHelper.getRecentOpportunities';
import { refreshApex } from '@salesforce/apex';

const PAGE_SIZE = 5;

const columns = [
    { label: 'Opportunity Name', fieldName: 'Name', type: 'text' },
    { label: 'Amount', fieldName: 'Amount', type: 'decimal' },
    { label: 'Close Date', fieldName: 'CloseDate', type: 'date-local' },
    // Add more columns as needed
];
 
export default class RecentOpportunities extends LightningElement {
    @track opportunityName = ''
    @track opportunities
    @track columns = columns
    @track showTable = false
    @track showEmptyMessage = false
    @track pageNumber = 1;
    
    @wire(getRecentOpportunities,{opportunityName: '$opportunityName', pageNumber: '$pageNumber'})
    wiredOpportunities({data,error})
    {
        if(data){
            this.opportunities = data
            this.showTable = this.opportunityName !== '' && this.showTable;
            this.showEmptyMessage = data.length === 0 && this.opportunityName !== '';
        } else if(error){
            console.error('Error Fatching Opportunities', error)
            this.opportunities = null
            this.showTable = false
            this.showEmptyMessage = false
        }
    }

    handleNameChange(event){
      this.opportunityName = event.target.value
    }

    searchOpportunities(){
        if(this.opportunityName){
            this.showTable = true;
            this.pageNumber = 1; // Reset page number when searching
            return refreshApex(this.wiredOpportunities);
        } else {
            // Clear the opportunities when opportunityName is empty
            this.opportunities = [];
            this.showTable = false
            this.showEmptyMessage = false
        }
    }
    handlePrevious() {
        if (this.pageNumber > 1) {
            this.pageNumber--;
            refreshApex(this.wiredOpportunities);
        }
    }
    handleNext() {
        this.pageNumber++;
        refreshApex(this.wiredOpportunities);
    }
}