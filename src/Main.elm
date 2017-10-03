module Main exposing (..)

import Routing exposing (Route)
import Html exposing (Html, text, div, img, a, footer, span, nav, ul, li, h1)
import Html.Attributes exposing (src, class, href)
import Html.Events exposing (onClick)


---- MODEL ----


type alias Model =
    { view : Route }


init : ( Model, Cmd Msg )
init =
    ( { view = Routing.HomeRoute
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = NavigateTo Routing.Route


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo route ->
            ( { model | view = route }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ applicationHeader model
        , applicationView model
        , applicationFooter
        ]


applicationFooter : Html Msg
applicationFooter =
    footer []
        [ div [ class "container" ]
            [ a [ href "/", class "logo-font" ] [ text "conduit" ]
            , span [ class "attribution" ]
                [ text "An interactive learning project from "
                , a [] [ text "Thinksters" ]
                , text ". Code & design licensed under MIT"
                ]
            ]
        ]


applicationHeader : Model -> Html Msg
applicationHeader model =
    let
        navItemClass =
            (\v ->
                if v == model.view then
                    "nav-item active"
                else
                    "nav-item"
            )
    in
        nav [ class "navbar navbar-light" ]
            [ div [ class "container" ]
                [ a [ class "navbar-brand", href "index.html" ]
                    [ text "conduit" ]
                , ul [ class "nav navbar-nav pull-xs-right" ]
                    [ li [ class (navItemClass Routing.HomeRoute) ]
                        [ a
                            [ class "nav-link"
                            , href "#/"
                            , onClick (NavigateTo Routing.HomeRoute)
                            ]
                            [ text "Home" ]
                        ]
                    , li [ class (navItemClass Routing.NewPostRoute) ]
                        [ a
                            [ class "nav-link"
                            , href "#/new"
                            , onClick
                                (NavigateTo Routing.NewPostRoute)
                            ]
                            [ text " New Post" ]
                        ]
                    , li [ class (navItemClass Routing.SettingsRoute) ]
                        [ a
                            [ class "nav-link"
                            , href "#/settings"
                            , onClick (NavigateTo Routing.SettingsRoute)
                            ]
                            [ text " Settings" ]
                        ]
                    , li [ class (navItemClass Routing.SignUpRoute) ]
                        [ a
                            [ class "nav-link"
                            , href "#/login"
                            , onClick (NavigateTo Routing.SignUpRoute)
                            ]
                            [ text "Sign up" ]
                        ]
                    ]
                ]
            ]


applicationView : Model -> Html Msg
applicationView model =
    case model.view of
        Routing.HomeRoute ->
            homeView model

        _ ->
            div [ class "container text-xs-center" ]
                [ text "Not implemented yet!" ]


homeView : Model -> Html Msg
homeView model =
    div [ class "home-page" ]
        [ div [ class "banner" ]
            [ div [ class "container" ]
                [ h1 [ class "logo-font" ]
                    [ text "conduit" ]
                ]
            ]
        , div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] [] ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
