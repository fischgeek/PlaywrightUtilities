namespace HtmxScraperUtils
//Op: Auto
open FSharp.Control.Tasks
open Microsoft.Playwright
open System
open System.Linq
open System.Text.Json
open System.Threading.Tasks

open PlaywrightUtilities
//Op: End
[<AutoOpen>]
module BrowserBasics =
    //type Browser =
    //    | Chromium
    //    | Chrome
    //    | Edge
    //    | Firefox
    //    | Webkit
    //    member this.AsString = this.ToString()


    let getPage (url: string) (browser: Task<IBrowser>) =
        task {
            let! browser = browser
            printfn $"Navigating to \"{url}\""
            let! page = browser.NewPageAsync()
            let! res = page.GotoAsync url

            if not res.Ok then
                // we should be able to handle this part better if
                // we use result instead of just the type
                return failwith "We couldn't navigate to that page"

            return page
        }
        |> fun x -> x

    let initBrowserTypeLaunchOptions (headless: bool) (sloMoTime: int) (timeout: float) =
        let btlo = BrowserTypeLaunchOptions()
        btlo.Headless <- headless
        btlo.SlowMo <- sloMoTime |> float32 |> Nullable
        btlo.Timeout <- timeout |> float32 |> Nullable
        btlo
