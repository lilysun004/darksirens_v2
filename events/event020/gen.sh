lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 35.31335335335336 --fixed-mass2 77.83963963963964 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1000935472.0829775 \
--gps-end-time 1000942672.0829775 \
--d-distr volume \
--min-distance 1946.7940007429613e3 --max-distance 1946.8140007429613e3 \
--l-distr fixed --longitude -138.5508270263672 --latitude -27.154216766357422 --i-distr uniform \
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
