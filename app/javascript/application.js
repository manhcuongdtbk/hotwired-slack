// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import PerfectScrollbar from 'perfect-scrollbar'
import * as bootstrap from "bootstrap"
import ApexCharts from 'apexcharts'
import {DataTable} from "simple-datatables"
import "./mazer/pages/dashboard"
import "./mazer/mazer"

// Simple Datatable
let table1 = document.querySelector('#table1');
let dataTable = new DataTable(table1);
import "./channels"
