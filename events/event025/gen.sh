lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 10.856536536536538 --fixed-mass2 39.263423423423426 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1031296333.3474196 \
--gps-end-time 1031303533.3474196 \
--d-distr volume \
--min-distance 1626.1480965093328e3 --max-distance 1626.1680965093328e3 \
--l-distr fixed --longitude 13.713998794555664 --latitude -16.06205940246582 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
