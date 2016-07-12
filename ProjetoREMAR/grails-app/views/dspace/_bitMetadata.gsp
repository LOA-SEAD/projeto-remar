<article class="width-position left-align">
    <section class="row">
        %{--<div class="col s6">--}%
        %{--<div class="card-content text-justify">--}%
        %{--<p>Metadados...</p>--}%
        %{--</div>--}%
        %{--</div>--}%
        <div class="col s12">
            <table class="bordered">
                <thead>
                <tr>
                    <th data-field="answer">Arquivo</th>
                    <th data-field="name">Descrição</th>
                    <th data-field="action"> </th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${bitstreams}" var="bitstream">
                    <tr class="line">
                        <td>
                            ${bitstream.name}
                        </td>
                        <td>
                            <input id="description" type="text" class="validate">
                            <label for="description">First Name</label>
                        </td>
                        <td>
                            <div class="">
                                <span>ver</span>
                            </div>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </section>
</article>