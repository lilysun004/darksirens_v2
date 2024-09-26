lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 37.162322322322325 --fixed-mass2 53.80304304304305 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029419905.363593 \
--gps-end-time 1029427105.363593 \
--d-distr volume \
--min-distance 4594.521707941396e3 --max-distance 4594.541707941396e3 \
--l-distr fixed --longitude 117.44607543945312 --latitude 10.810035705566406 --i-distr uniform \
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
